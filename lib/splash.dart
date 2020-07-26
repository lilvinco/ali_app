import 'dart:async';
import 'package:Ali/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(17, 24, 32, 1),
        body: Center(
            child: Container(
              height: 198,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset('assets/images/logo.png', height: 126,width: 109, fit: BoxFit.cover,)
            )));
  }
}