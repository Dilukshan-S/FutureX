import cv2
import numpy as np
from scipy import signal
from keras.models import load_model
import time

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
model = load_model('emotion_detection_model.h5')

emotion_labels = ['Angry', 'Disgust', 'Fear', 'Happy', 'Neutral', 'Sad', 'Surprise']
cap = cv2.VideoCapture(0)
fps = cap.get(cv2.CAP_PROP_FPS)
start_time = time.time()
frames = []
images = []
emotions = {'Angry': 0, 'Disgust': 0, 'Fear': 0, 'Happy': 0, 'Neutral': 0, 'Sad': 0, 'Surprise': 0}
while (time.time() - start_time) < 120:
    ret, img = cap.read()
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    for (x, y, w, h) in faces:
        roi_gray = gray[y:y+h, x:x+w]
        roi_gray = cv2.resize(roi_gray, (48, 48), interpolation=cv2.INTER_AREA)
        label_text = ""
        if np.sum([roi_gray]) != 0:
            roi = roi_gray.astype('float')/255.0
            roi = np.reshape(roi, (1, 48, 48, 1))
            preds = model.predict(roi)[0]
            label = preds.argmax()
            label_text = emotion_labels[label]
            emotions[label_text] += 1
            # If negative emotion detected, print message
            if label_text in ['Angry', 'Disgust', 'Fear', 'Sad']:
                print('Negative emotion detected: ', label_text)
            cv2.putText(img, label_text, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)
        images.append(img)
        frames.append(label_text)
    cv2.imshow('img', img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()

# Calculate pulse from video frames
green_frames = [frame[:, :, 1] for frame in images]
# Apply bandpass filter to remove noise
fs = fps
lowcut = 0.7
highcut = 4
nyquist = 0.5 * fs
low = lowcut / nyquist
high = highcut / nyquist
order = 2
b, a = signal.butter(order, [low, high], btype='band')
filtered_frames = [signal.filtfilt(b, a, frame) for frame in green_frames]
# Apply temporal averaging filter
n = 3
avg_filtered_frames = [np.mean(filtered_frames[i:i+n], axis=0) for i in range(len(filtered_frames)-n+1)]
means = [np.mean(frame) for frame in avg_filtered_frames]
diffs = np.diff(means)
peaks = np.where(diffs > 0)[0]
pulse = len(peaks) / (2.0 * fps)
print('Pulse (bpm):', round(pulse * 60 * 1.21, 2))

# Calculate percentage of different emotions
emotion_counts = {label: frames.count(label) for label in emotion_labels}
total_frames = len(frames)
print("Emotion percentages:")
for label, count in emotion_counts.items():
    percentage = count / total_frames * 100
    print(f"{label}: {percentage:.2f}%")

print('User emotion:', frames[-1])