import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:mindrate/landing_page.dart';
import 'package:mindrate/mood_boost.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mindrate/widgets/exercise_card.dart';
import 'package:path/path.dart' as path;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isStarted = false;
  bool isFirst = true;
  int meditation = 0;
  int nature = 0;
  int yoga = 0;
  Timer? periodicTimer;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    periodicTimer?.cancel();
  }

  void copyFileToRootFolder(String sourceFilePath, String fileName) {
    final file = File(sourceFilePath);
    final parentDirectory = file.parent;
    final destinationFilePath = '${Directory.current.path}/$fileName';

    if (parentDirectory.existsSync()) {
      // Create the destination directory if it doesn't exist
      final destinationDirectory = Directory(Directory.current.path);
      if (!destinationDirectory.existsSync()) {
        destinationDirectory.createSync(recursive: true);
      }

      // Copy the file to the destination directory
      file.copySync(destinationFilePath);

      print('File copied to root folder successfully');
    } else {
      print('Source file path is not valid');
    }
  }

  Future<void> recordVideo(context) async {
    // Get the list of available cameras
    final cameras = await availableCameras();

    // Select the first camera from the list
    final camera = cameras.first;

    // Initialize the camera controller
    final cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    // Start the camera feed
    await cameraController.initialize();

    // Start recording
    final recording = await cameraController.startVideoRecording();

    if (isFirst) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Camera Started", textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/camer_on.png", width: 200),
                Text(
                    "The app will be access you web camera and start to monitor your video feed"),
              ],
            ),
          );
        },
      );

      Timer(Duration(seconds: 5), () {
        Navigator.pop(context);
      });
    }

    // Wait for 15 seconds
    await Future.delayed(Duration(seconds: 15));

    // Stop recording
    XFile videoFile = await cameraController.stopVideoRecording();
    print('Video file saved to: ${videoFile.path}');

    cameraController.dispose();

    copyFileToRootFolder(videoFile.path, "video.mp4");

    final originalPath = videoFile.path;

    // Create a File object representing the original file
    final file = File(originalPath);

    // Use the delete() method to delete the original file
    await file.delete();

    print('File moved successfully!');

    print('Video saved successfully');
  }

  Future<void> uploadVideo(File videoFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:1010/api'),
    );

    // Set the file field name and file content
    var file = await http.MultipartFile.fromPath('video_file', videoFile.path);

    // Add the file to the request payload
    request.files.add(file);

    try {
      // Send the request and get the response
      var response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

        // Parse the string into a JSON object
        Map jsonResponse = json.decode(responseString);
        print('response $jsonResponse');
        LocalNotification notification = LocalNotification(
          title: jsonResponse["emotions"],
          body: jsonResponse["final_activity"],
        );

        notification.show();
        print('Video uploaded successfully');
      } else {
        print('Error uploading video');
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  Future<int> getData(String type) async {
    List<Document> list = await Firestore.instance
        .collection(type)
        .where("user_id", isEqualTo: _auth.currentUser!.uid)
        .get();
    int totalTime = 0;
    for (Document doc in list) {
      totalTime += doc.map['seconds'] as int;
    }
    print("Total Time: " + totalTime.toString());

    return totalTime;
  }

  setData() async {
    meditation = await getData("Meditation");
    nature = await getData("Nature Observation");
    yoga = await getData("Yoga and Stretching");
    setState(() {});
  }

  @override
  void initState() {
    setData();
    print("Name: " + _auth.currentUser!.displayName!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: AppBar(
            iconTheme: IconThemeData(color: Color(0xff5A4AE3)),
            backgroundColor: Colors.transparent,
            title: Image.asset("assets/home_logo.png", height: 60),
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      _auth.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context) => LandingPage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Icon(Icons.logout, color: Colors.red, size: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 110, 80, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("assets/bot.png"),
                  SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Hello ',
                        style: TextStyle(
                            color: Color(0xff10217D),
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: _auth.currentUser!.displayName,
                            style: TextStyle(
                                color: Color(0xff2E4450),
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 250),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: ExerciseCard(
                              name: 'Meditation',
                              time: meditation,
                              img: 'assets/meditation.png')),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: ExerciseCard(
                              name: 'Nature Observation',
                              time: nature,
                              img: 'assets/nature_observation.png')),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: ExerciseCard(
                              name: 'Yoga and Stretching',
                              time: yoga,
                              img: 'assets/yoga.png')),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!isStarted) {
                    try {
                      //todo: Change Time
                      periodicTimer =
                          Timer.periodic(Duration(seconds: 30), (timer) async {
                        try {
                          print("Called");
                          await recordVideo(context);
                          var videoFile = File('video.mp4');
                          uploadVideo(videoFile);
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text("Camera not available",
                                    textAlign: TextAlign.center),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("assets/camera.png",
                                        width: 200),
                                    Text(
                                      "We could not access your device's camera. \nPlease make sure it is not being used by another app \nor that your device has a camera.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                        color: Color(0xff10217D),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                      setState(() {
                        isStarted = true;
                      });
                      await recordVideo(context);
                      var videoFile = File('video.mp4');
                      uploadVideo(videoFile);
                    } catch (e) {
                      periodicTimer?.cancel();
                      setState(() {
                        isStarted = false;
                        isFirst = true;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text("Camera not available",
                                textAlign: TextAlign.center),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/camera.png", width: 200),
                                Text(
                                  "We could not access your device's camera. \nPlease make sure it is not being used by another app \nor that your device has a camera.",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Color(0xff10217D),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    print("else called");
                    setState(() {
                      isStarted = false;
                      isFirst = true;
                    });
                    periodicTimer?.cancel();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2E4450),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  isStarted ? "Stop Monitoring" : "Monitor Me",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffF6F6F7),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => MoodBoost()))
                      .then((value) {
                    setData();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff10217D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Mind Boost",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffF6F6F7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
