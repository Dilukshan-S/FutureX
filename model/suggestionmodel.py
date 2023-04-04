
import pandas as pd
import random
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier

# Load data
url = 'https://drive.google.com/file/d/1cynydrPwb2aB1cWNU2nwpDwWSuvgFl7_/view?usp=share_link'
file_id = url.split("/")[-2]
dwn_url = f"https://drive.google.com/uc?id={file_id}"
data = pd.read_csv(dwn_url)

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
activity = clf.predict([emotions])
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