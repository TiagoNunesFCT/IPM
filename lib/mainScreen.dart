import 'dart:async';

import 'package:flutter/material.dart';

import 'genericPage.dart';

// ignore: must_be_immutable
class MainPage extends GenericPage {
  //empty constructor, there isn't much we can do here
  MainPage();

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends GenericPageState {
  @override
  void initState() {

    super.initState();
  }

  //Build the widget
  @override
  Widget build(BuildContext context) {
    Widget page = Scaffold(appBar: new AppBar(
      backgroundColor: const Color(0xFF1D1D1D),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
      body:Center(
      child: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1D1D1D),))
    );
    return page;
  }



}


