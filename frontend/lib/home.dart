import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Contact Us",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff2E4450),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "About Us",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff2E4450),
                  ),
                ),
                SizedBox(
                  width: 55,
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Image.asset("assets/home_logo.png", width: 300),
            SizedBox(
              height: 40,
            ),
            Image.asset("assets/home_img.png", width: 300),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2E4450),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Play Demo",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffF6F6F7),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff10217D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffF6F6F7),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: Stack(
                  children: [
                    Image.asset("assets/youtube.png", width: 33, height: 35),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25, top: 50),
                      child: Image.asset("assets/instagram.png",
                          width: 30, height: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, top: 100),
                      child: Image.asset("assets/facebook.png",
                          width: 30, height: 30),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
