import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/login.dart';

import 'home.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp(BuildContext context) async {

    showDialog(
        context: context,
        builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    try{
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User user = _auth.currentUser!;

      String newDisplayName = nameController.text.trim();

      await user.updateDisplayName(newDisplayName).then((_) {
        print("Display name updated successfully");
        print("Name: "+user.displayName!);
      }).catchError((error) {
        print("Error updating display name: $error");
      });

      Navigator.pop(context);

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
        content: AwesomeSnackbarContent(
          title: "Hooooooray !",
          message: 'Your Account Successfully Created',

          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);


      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);

    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          dismissDirection: DismissDirection.horizontal,
          content: AwesomeSnackbarContent(
            title: "Oooooops!",
            message: 'The password provided is too weak',

            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          dismissDirection: DismissDirection.horizontal,
          content: AwesomeSnackbarContent(
            title: "Oooooops!",
            message: 'The account already exists for that email',

            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
        content: AwesomeSnackbarContent(
          title: "Oooooops!",
          message: e.toString(),

          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

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
            SizedBox(
              width: 600,
            ),
            Expanded(
              child: Container(
                color: Color(0xff2E4450),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: Image.asset("assets/logo.png", width: 300)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Signup with",
                            style: GoogleFonts.ubuntu(
                                color: Color(0xffDBDBE1),
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: nameController,
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.person_outline,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Name",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: emailController,
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.email_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Email",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.visibility_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Password",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.visibility_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Re-enter Password",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 80,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signUp(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffAAA3E9)),
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Signup",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.push(context,
                                  CupertinoPageRoute(builder: (_) => Login())),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Do you have an account?  ',
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Login',
                                        style: GoogleFonts.outfit(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff00C0FF),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
