import cv2
import time

output_file = 'video.avi'
frames_per_second = 30
number_of_frames = 3600

# Open a connection to the d efault camera
cap = cv2.VideoCapture(0)

# Get the size of the frames from the camera
frame_size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)),
              int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))

# Define the codec and create a VideoWriter object
fourcc = cv2.VideoWriter_fourcc(*'MJPG')
video_writer = cv2.VideoWriter(output_file, fourcc, frames_per_second, frame_size, isColor=True)

start_time = time.time()

# Capture and write the frames to the video file
for i in range(number_of_frames):
    ret, frame = cap.read()
    if ret:
        video_writer.write(frame)
    else:
        print('Error capturing frame.')
        break

end_time = time.time()
elapsed_time = end_time - start_time
print(f'Time taken: {elapsed_time:.2f} seconds')
print(f'Estimated frames per second: {number_of_frames / elapsed_time:.2f}')

# Release the resources
cap.release()
video_writer.release()
cv2.destroyAllWindows()
