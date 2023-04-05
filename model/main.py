import numpy as np
import cv2
import sys
import csv
import time
import backend

#loading the emotion values

stressed,sadness,anxious = backend.emotions()

# Helper Methods
def buildGauss(frame, levels):
    pyramid = [frame]
    for level in range(levels):
        frame = cv2.pyrDown(frame)
        pyramid.append(frame)
    return pyramid
def reconstructFrame(pyramid, index, levels):
    filteredFrame = pyramid[index]
    for level in range(levels):
        filteredFrame = cv2.pyrUp(filteredFrame)
    filteredFrame = filteredFrame[:videoHeight, :videoWidth]
    return filteredFrame

# Webcam Parameters
webcam = None
if len(sys.argv) == 2:
    webcam = cv2.VideoCapture(sys.argv[1])
else:
    webcam = cv2.VideoCapture(0)
realWidth = 320
realHeight = 240
videoWidth = 160
videoHeight = 120
videoChannels = 3
videoFrameRate = 15
webcam.set(3, realWidth)
webcam.set(4, realHeight)

t_end=time.time()+10


# Output Videos
if len(sys.argv) != 2:
    originalVideoFilename = "original.mov"
    originalVideoWriter = cv2.VideoWriter()
    originalVideoWriter.open(originalVideoFilename, cv2.VideoWriter_fourcc('j', 'p', 'e', 'g'), videoFrameRate, (realWidth, realHeight), True)



outputVideoFilename = "output.mov"
outputVideoWriter = cv2.VideoWriter()
outputVideoWriter.open(outputVideoFilename, cv2.VideoWriter_fourcc('j', 'p', 'e', 'g'), videoFrameRate, (realWidth, realHeight), True)

# Color Magnification Parameters
levels = 3
alpha = 170
minFrequency = 1.0
maxFrequency = 2.0
bufferSize = 150
bufferIndex = 0

# Output Display Parameters
font = cv2.FONT_HERSHEY_SIMPLEX
loadingTextLocation = (20, 30)
bpmTextLocation = (videoWidth//2 + 5, 30)
fontScale = 1
fontColor = (255,255,255)
lineType = 2
boxColor = (0, 255, 0)
boxWeight = 3
list_bpm = []

# Initialize Gaussian Pyramid
firstFrame = np.zeros((videoHeight, videoWidth, videoChannels))
firstGauss = buildGauss(firstFrame, levels+1)[levels]
videoGauss = np.zeros((bufferSize, firstGauss.shape[0], firstGauss.shape[1], videoChannels))
fourierTransformAvg = np.zeros((bufferSize))

# Bandpass Filter for Specified Frequencies
frequencies = (1.0*videoFrameRate) * np.arange(bufferSize) / (1.0*bufferSize)
mask = (frequencies >= minFrequency) & (frequencies <= maxFrequency)

# Heart Rate Calculation Variables
bpmCalculationFrequency = 15
bpmBufferIndex = 0
bpmBufferSize = 10
bpmBuffer = np.zeros((bpmBufferSize))

i = 0
while time.time() <t_end:
    ret, frame = webcam.read()
    if ret == False:
        break

    if len(sys.argv) != 2:
        originalFrame = frame.copy()
        originalVideoWriter.write(originalFrame)

    detectionFrame = frame[videoHeight//2:realHeight-videoHeight//2, videoWidth//2:realWidth-videoWidth//2, :]

    # Construct Gaussian Pyramid
    videoGauss[bufferIndex] = buildGauss(detectionFrame, levels+1)[levels]
    fourierTransform = np.fft.fft(videoGauss, axis=0)

    # Bandpass Filter
    fourierTransform[mask == False] = 0

    # Grab a Pulse
    if bufferIndex % bpmCalculationFrequency == 0:
        i = i + 1
        for buf in range(bufferSize):
            fourierTransformAvg[buf] = np.real(fourierTransform[buf]).mean()
        hz = frequencies[np.argmax(fourierTransformAvg)]
        bpm = 60.0 * hz
        bpmBuffer[bpmBufferIndex] = bpm
        bpmBufferIndex = (bpmBufferIndex + 1) % bpmBufferSize

    # Amplify
    filtered = np.real(np.fft.ifft(fourierTransform, axis=0))
    filtered = filtered * alpha

    # Reconstruct Resulting Frame
    filteredFrame = reconstructFrame(filtered, bufferIndex, levels)
    outputFrame = detectionFrame + filteredFrame
    outputFrame = cv2.convertScaleAbs(outputFrame)

    bufferIndex = (bufferIndex + 1) % bufferSize

    frame[videoHeight//2:realHeight-videoHeight//2, videoWidth//2:realWidth-videoWidth//2, :] = outputFrame
    cv2.rectangle(frame, (videoWidth//2 , videoHeight//2), (realWidth-videoWidth//2, realHeight-videoHeight//2), boxColor, boxWeight)
    if i > bpmBufferSize:

        list_bpm.append(bpmBuffer.mean())

        cv2.putText(frame, "BPM: %d" % bpmBuffer.mean(), bpmTextLocation, font, fontScale, fontColor, lineType)
    else:
        cv2.putText(frame, "Calculating BPM...", loadingTextLocation, font, fontScale, fontColor, lineType)

    outputVideoWriter.write(frame)

    if len(sys.argv) != 2:
        cv2.imshow("Webcam Heart Rate Monitor", frame)
        print(list_bpm)

        with open('Example.csv', 'w', newline='') as csvfile:
            my_writer = csv.writer(csvfile, delimiter=' ')
            my_writer.writerow(list_bpm)







        #if cv2.waitKey(1) & 0xFF == ord('q'):
            #print(list_bpm)

            #with open('Example.csv', 'w', newline='') as csvfile:
                #my_writer = csv.writer(csvfile, delimiter='')
                #my_writer.writerow(list_bpm)




    if len(sys.argv) != 2:
        cv2.imshow("Webcam Heart Rate Monitor", frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

webcam.release()
cv2.destroyAllWindows()
outputVideoWriter.release()
if len(sys.argv) != 2:
    originalVideoWriter.release()


   

    def calculate_hrv(hr_values):
        # Step 1: Calculate the mean HR
        mean_hr = sum(hr_values) / len(hr_values)

        # Step 2: Calculate the difference between each HR value and the mean HR
        hr_diffs = [hr - mean_hr for hr in hr_values]

        # Step 3: Square the differences
        hr_diffs_squared = [diff ** 2 for diff in hr_diffs]

        # Step 4: Sum the squared differences
        sum_squared_diffs = sum(hr_diffs_squared)

        # Step 5: Divide the sum of squared differences by the number of HR values minus one
        variance_hr = sum_squared_diffs / (len(hr_values) - 1)

        # Step 6: Calculate the standard deviation of the HR values
        sd_hr = math.sqrt(variance_hr)

        # Step 7: Calculate the natural logarithm of the SD to get HRV
        hrv = math.log(sd_hr)

        return mean_hr, hrv


    # Load data
    url = 'https://drive.google.com/file/d/1cynydrPwb2aB1cWNU2nwpDwWSuvgFl7_/view?usp=share_link'
    file_id = url.split("/")[-2]
    dwn_url = f"https://drive.google.com/uc?id={file_id}"
    data = pd.read_csv(dwn_url)

   # hr_values = [60, 65, 70, 75, 80, 85, 90, 95]
    mean, hrv = calculate_hrv(list_bpm)

    # Split data into features and labels
    X = data.drop('activity', axis=1)
    y = data['activity']

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train decision tree classifier
    clf = DecisionTreeClassifier(random_state=42)
    clf.fit(X_train, y_train)

    # Predict activities based on emotional states
    emotions = [stressed, sadness, anxious]
    emotions_hrstuff = []
    emotions_hrstuff.extend(emotions)
    emotions_hrstuff.append(mean)
    emotions_hrstuff.append(hrv)
    activity = clf.predict([emotions_hrstuff])
    final_activity = str(activity).replace("_", " ").replace("[", "").replace("]", "").replace("'", "")
    if final_activity == "normal":
        print(final_activity)
    else:
        highest_emotion = max(emotions)
        index = emotions.index(highest_emotion)
        if index == 0:
            emotions = "stressed"
        elif index == 1:
            emotions= "sad"
        else:
            emotions = "tired"
        print("Are you feeling " + emotions + "?")
        print("If so, " + final_activity)
