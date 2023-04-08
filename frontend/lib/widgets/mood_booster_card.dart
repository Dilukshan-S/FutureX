import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodBoosterCard extends StatelessWidget {
  final String img;
  final String label;
  final Function onTap;

  const MoodBoosterCard({Key? key, required this.img, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(img,
                  height: 80, width: 100),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff5A4AE3), Color(0xff10217D)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  border: Border.all(color: Colors.white, width: 3)),
              child: SizedBox(
                height: 70,
                width: 250,
                child: Center(
                  child: Text(
                    label,
                    style:
                    TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
