import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindrate/home.dart';
import 'package:mindrate/login.dart';
import 'package:mindrate/signup.dart';

class Auth extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser(){
    User? user = _auth.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return getCurrentUser() == null ? Login() : Home();
  }
}
