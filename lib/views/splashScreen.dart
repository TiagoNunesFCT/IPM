import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zone/views/mainScreen.dart';

import 'genericPage.dart';

// ignore: must_be_immutable
class SplashScreen extends GenericPage {
  //empty constructor, there isn't much we can do here
  SplashScreen();

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends GenericPageState {
  @override
  void initState() {

    super.initState();
    timerStart();
  }

  //Build the widget
  @override
  Widget build(BuildContext context) {
    Widget about = Scaffold(


      body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF1D1D1D),
            child: Container(width: 100, height:100,child:Image(image:AssetImage("assets/small_logo.png"))),
          )),
    );
    return about;
  }
  //splash timer start
  timerStart() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MainPage()
    )
    );
  }

}

