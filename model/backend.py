import cv2
import numpy as np
from scipy import signal
from keras.models import load_model
import time
import datetime


def emotions():
    face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
    model = load_model('emotion_detection_model.h5')

    emotion_labels = ['Angry', 'Disgust', 'Anxiety', 'Happy', 'Neutral', 'Sad', 'Surprise']
    cap = cv2.VideoCapture(0)
    fps = cap.get(cv2.CAP_PROP_FPS)
    start_time = time.time()
    frames = []
    images = []
    emotions = {'Angry': 0, 'Disgust': 0, 'Anxiety': 0, 'Happy': 0, 'Neutral': 0, 'Sad': 0, 'Surprise': 0}
    while (time.time() - start_time) < 10:
        ret, img = cap.read()
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gray, 1.3, 5)
        for (x, y, w, h) in faces:
            roi_gray = gray[y:y + h, x:x + w]
            roi_gray = cv2.resize(roi_gray, (48, 48), interpolation=cv2.INTER_AREA)
            label_text = ""
            if np.sum([roi_gray]) != 0:
                roi = roi_gray.astype('float') / 255.0
                roi = np.reshape(roi, (1, 48, 48, 1))
                preds = model.predict(roi)[0]
                label = preds.argmax()
                label_text = emotion_labels[label]
                emotions[label_text] += 1

                # If negative emotion detected, print message
                if label_text in ['Angry', 'Disgust', 'Anxiety', 'Sad']:
                    print('Negative emotion detected: ', label_text)
                cv2.putText(img, label_text, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
            cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
            images.append(img)
            frames.append(label_text)
        cv2.imshow('img', img)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

    # Calculate percentage of different emotions
    angry_disgust_count = emotions['Angry'] + emotions['Disgust']
    total_frames = len(frames)
    percentage_angry_disgust = angry_disgust_count / total_frames
    percentage_anxiety = emotions['Anxiety'] / total_frames
    percentage_sad = emotions['Sad'] / total_frames

    print("Emotion percentages:")
    print(f"Angry-Disgust: {percentage_angry_disgust:.2f}")
    print(f"Anxiety: {percentage_anxiety:.2f}")
    print(f"Sad: {percentage_sad:.2f}")

    # Save data to file
    now = datetime.datetime.now()
    filename = f"negative_emotion_data_{now.strftime('%Y-%m-%d_%H-%M-%S')}.txt"
    with open(filename, 'w') as f:
        f.write(f"{percentage_angry_disgust:.2f}\n")
        f.write(f"{percentage_anxiety:.2f}\n")
        f.write(f"{percentage_sad:.2f}\n")
        f.close()
        
    return percentage_angry_disgust,percentage_sad,percentage_anxiety
  
