import pandas as pd
import random
import math
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier


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
    
    return mean_hr,hrv

# Load data
url = 'https://drive.google.com/file/d/1cynydrPwb2aB1cWNU2nwpDwWSuvgFl7_/view?usp=share_link'
file_id = url.split("/")[-2]
dwn_url = f"https://drive.google.com/uc?id={file_id}"
data = pd.read_csv(dwn_url)

hr_values = [60, 65, 70, 75, 80, 85, 90, 95]
mean,hrv = calculate_hrv(hr_values)

# Split data into features and labels
X = data.drop('activity', axis=1)
y = data['activity']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train decision tree classifier
clf = DecisionTreeClassifier(random_state=42)
clf.fit(X_train, y_train)

# Predict activities based on emotional states
emotions = [random.uniform(0,1),random.uniform(0,1),random.uniform(0,1)]
emotions_hrstuff = []
emotions_hrstuff.extend(emotions)
emotions_hrstuff.append(mean)
emotions_hrstuff.append(hrv)
activity = clf.predict([emotions_hrstuff])
final_activity = str(activity).replace("_"," ").replace("[","").replace("]","").replace("'","")
if final_activity=="normal":
    print(final_activity)
else :
  highest_emotion = max(emotions)
  index = emotions.index(highest_emotion)
  if index==0:
    emotionfelt="stressed"
  elif index==1:
    emotionfelt="sad"
  else :
    emotionfelt="tired"
  print("Are you feeling "+emotionfelt+"?")
  print("If so, "+final_activity)
