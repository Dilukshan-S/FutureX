import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final int time;
  final String img;

  const ExerciseCard({Key? key, required this.name, required this.time, required this.img}) : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name+" "+widget.time.toString());
  }

  String getTimeString(int elapsedSeconds){
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds ~/ 60) % 60;
    final seconds = elapsedSeconds % 60;
    final timeString = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color(0xffE6E3F8),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(widget.img,width: 30,)
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.name,
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Color(0xff5A4AE3),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              getTimeString(widget.time),
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Color(0xff2E4450),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
