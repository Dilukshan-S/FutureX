import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:mindrate/mood_boost.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class Home extends StatelessWidget {
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

  Future<void> recordVideo() async {
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
      Uri.parse('http://167.71.193.18:1010/api'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Chamelee G.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset("assets/avatar.png")
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 100, 80, 50),
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Hello',
                        style: TextStyle(
                            color: Color(0xff10217D),
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nChamelee Gurusinghe',
                            style: TextStyle(
                                color: Color(0xff2E4450),
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/bot.png"),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "How are you feeling today?",
                style: GoogleFonts.poppins(
                    color: Color(0xff2E4450),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Image.asset("assets/happy_face.png",
                              height: 70, width: 70),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 60),
                              child: Text(
                                "Happy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Image.asset("assets/happy_face.png",
                              height: 70, width: 70),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 60),
                              child: Text(
                                "Sad",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Image.asset("assets/happy_face.png",
                              height: 70, width: 70),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 60),
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Image.asset("assets/happy_face.png",
                              height: 70, width: 70),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 60),
                              child: Text(
                                "Happy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () async {
                  await recordVideo();

                  var videoFile = File('video.mp4');
                  uploadVideo(videoFile);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2E4450),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Start My Day",
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
