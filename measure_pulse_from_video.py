import cv2
import numpy as np

cap = cv2.VideoCapture(0)

# Initialize variables
fps = cap.get(cv2.CAP_PROP_FPS)
prev_gray = None
pulse_rates = []

while True:
    # Read the frame from the video capture object
    ret, frame = cap.read()

    # Convert the frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Initialize the previous grayscale frame (for the first iteration)
    if prev_gray is None:
        prev_gray = gray
        continue

    # Compute the optical flow using the Lucas-Kanade algorithm
    flow = cv2.calcOpticalFlowFarneback(prev_gray, gray, None, 0.5, 3, 15, 3, 5, 1.2, 0)

    # Compute the magnitude of the optical flow vectors
    mag = np.sqrt(flow[...,0]**2 + flow[...,1]**2)

    # Compute the average magnitude in the face region
    roi = [100, 100, 200, 200] # x, y, width, height
    x, y, w, h = roi
    roi_mag = mag[y:y+h, x:x+w]
    avg_mag = np.mean(roi_mag)

    # Convert the average magnitude to a pulse rate in BPM
    pulse_rate = 60 * fps * (avg_mag / 100.0)
    pulse_rates.append(pulse_rate)

    # Update the previous grayscale frame
    prev_gray = gray

    # Display the frame with the pulse rate
    cv2.putText(frame, f'Pulse: {int(pulse_rate)} BPM', (20, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    cv2.imshow('Video', frame)

    # Exit on 'q' key press
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture object and close all windows
cap.release()
cv2.destroyAllWindows()

# Print the average pulse rate over the entire video
avg_pulse_rate = np.mean(pulse_rates)
print(f'Average pulse rate: {int(avg_pulse_rate)} BPM')