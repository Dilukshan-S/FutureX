import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/resources_page.dart';

class MoodBoost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Sign Out'),
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
            title: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff10217D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "View Journey",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffF6F6F7),
                ),
              ),
            ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(70),
                        bottomLeft: Radius.circular(10)),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset("assets/boost_img.png",
                            height: 100, width: 70),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(100),
                                bottomLeft: Radius.circular(10)),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 60),
                            child: Text(
                              "Mood Check-In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset("assets/boost_img.png",
                            height: 100, width: 70),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Text(
                              "Gratitude Journaling",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(70)),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset("assets/boost_img.png",
                            height: 100, width: 70),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(100)),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 35),
                            child: Text(
                              "Mindfulness Exercises",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => ResourcesPage()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(80),
                          bottomRight: Radius.circular(70),
                          bottomLeft: Radius.circular(10)),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Image.asset("assets/boost_img.png",
                              height: 100, width: 70),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 35),
                              child: Text(
                                "Resources & Support",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset("assets/boost_img.png",
                            height: 100, width: 70),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 90),
                            child: Text(
                              "Schedule",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(70)),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset("assets/boost_img.png",
                            height: 100, width: 70),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(100)),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 80),
                            child: Text(
                              "Daily Goals",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
