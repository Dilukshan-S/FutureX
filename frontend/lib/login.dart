import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/login_back.png"),
          fit: BoxFit.fill,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              color: Colors.white,
            ),
            SizedBox(
              width: 600,
            ),
            Expanded(
              child: Container(
                color: Color(0xff2E4450),
                child: Column(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
