import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerStart extends StatefulWidget {
  final String type;

  const TimerStart({Key? key, required this.type}) : super(key: key);

  @override
  State<TimerStart> createState() => _TimerStartState();
}

class _TimerStartState extends State<TimerStart> {
  Timer? timer;
  int seconds = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String getTimeString(int elapsedSeconds){
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds ~/ 60) % 60;
    final seconds = elapsedSeconds % 60;
    final timeString = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return timeString;
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text("Timer Started",textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/timer.png", width: 150),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff2E4450),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                getTimeString(seconds),
                style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () async {
                timer?.cancel();
                await Firestore.instance.collection(widget.type).document(DateTime.now().toString()).set({
                  'seconds': seconds,
                  'timestamp': DateTime.now(),
                  'user_id': _auth.currentUser!.uid
                });


                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5A4AE3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 110),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: SizedBox(
                width: 100,
                child: Text(
                  "Stop Timer",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffF6F6F7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
