import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/mood_boost.dart';

class Home extends StatelessWidget {
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
                onPressed: () {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (_) => MoodBoost()));
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
