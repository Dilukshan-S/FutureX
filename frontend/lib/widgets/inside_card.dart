import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/widgets/timer_start.dart';

class InsideCard extends StatefulWidget {
  final String img;
  final String title;
  final String txt;
  final String popupTxt;
  final String type;
  final Function onTap;

  const InsideCard({Key? key, required this.img, required this.title, required this.txt, required this.popupTxt, required this.type, required this.onTap}) : super(key: key);

  @override
  State<InsideCard> createState() => _InsideCardState();
}

class _InsideCardState extends State<InsideCard> {
  int seconds = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 670,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(widget.img,width: 110),
              SizedBox(
                height: 40,
              ),
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                    fontSize: 23,
                    color: Color(0xff5A4AE3),
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.txt,
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Color(0xff2E4450),
                    height: 1.6,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.justify,
              ),
              Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: (){
                  widget.onTap();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2E4450),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 105),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Learn More",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffF6F6F7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text("Test Text",textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                          content: SizedBox(
                            width: 600,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/timer.png", width: 150),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(widget.popupTxt,textAlign: TextAlign.justify,style: TextStyle(height: 1.5),),
                              ],
                            ),
                          ),
                          actions: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return TimerStart(type: widget.type);
                                        }
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff5A4AE3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 110),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: SizedBox(
                                    width: 80,
                                    child: Text(
                                      "Let's Start",
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
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2E4450),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 110),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Let's Start",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffF6F6F7),
                    ),
                    textAlign: TextAlign.center,
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
