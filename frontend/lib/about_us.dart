import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/about_us.png"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 82),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  "ABOUT US",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3,
                    color: Color(0xffF9A62D),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 800),
                child: Text(
                  "Our Mission",
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff808080),
                      height: 1.8
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 800),
                child: Text(
                  "To provide users with a simple, efficient, and customizable tool to monitor and improve their mental well-being. We strive to empower individuals to take control of their mental health by providing them with personalized insights and resources. Our goal is to break down the stigma surrounding mental health and create a community of support and understanding.",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff808080),
                    height: 1.6
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
