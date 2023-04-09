import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/exercises.dart';
import 'package:mindrate/resources_page.dart';
import 'package:mindrate/widgets/mood_booster_card.dart';

class MoodBoost extends StatefulWidget {
  @override
  State<MoodBoost> createState() => _MoodBoostState();
}

class _MoodBoostState extends State<MoodBoost> {
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
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.logout, color: Colors.red, size: 30),
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
          padding: const EdgeInsets.symmetric(horizontal: 110),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MoodBoosterCard(img: "assets/exercise.png", label: "Mindfulness Exercises", onTap: (){
                        {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_) => Exercises())).then((value) => setState(() {}));
                        }
                      }),
                      SizedBox(
                        height: 80,
                      ),
                      MoodBoosterCard(img: "assets/journaling.png", label: "Gratitude Journaling", onTap: (){}),
                    ],
                  ),
                  Image.asset("assets/human.png"),
                  Column(
                    children: [
                      MoodBoosterCard(img: "assets/goals.png", label: "Daily Goals", onTap: (){}),
                      SizedBox(
                        height: 80,
                      ),
                      MoodBoosterCard(img: "assets/resource.png", label: "Resources & Support", onTap: (){}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
