import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zone/rover.dart';
import 'package:zone/userScreen.dart';


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

  String zoneName = "Laranjeiro e Feijó";
  String cityName = "Almada";
  String zoneQuality = "Average";
  String zoneRanking = "(47th)";

  //Build the widget
  @override
  Widget build(BuildContext context) {
    Widget page = Scaffold(
        appBar: new AppBar(
          leading: Container(
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.supervised_user_circle_rounded),
                onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
  },
              ),
            ),
          ),
          actions: [
            Container(
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.settings_rounded, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ],
          centerTitle: true,
          title: new Text(
            'ZONeX',
            style: TextStyle(
              fontFamily: "Nasalization",
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1D1D1D),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF1D1D1D),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(
                      'Current Zone:',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 9.5, 10, 9.5),
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black38,
                            border: new Border.all(
                              color: Colors.white12,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  zoneName,
                                  style: TextStyle(
                                    fontFamily: "Nasalization",
                                    color: (ratingToColor(zoneQuality)),
                                    fontSize: 24,
                                  ),
                                )
                              ])),Container(width:2),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0x61111111),
                            border: new Border.all(
                              color: Colors.white12,
                              width: 1.0,
                            ),
                          ),child:IconButton(icon: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,), color: Colors.white,))]),SizedBox(height:60),new Rover(false, true, true)
                  ]),

                ],
              ),
            )));
    return page;
  }
}

Color ratingToColor(String color) {
  switch (color) {
    case "Horrible":
      return Colors.red.shade900;
      break;
    case "Bad":
      return Colors.orange.shade900;
      break;
    case "Unpleasant":
      return Colors.orange.shade700;
      break;
    case "Average":
      return Colors.yellow.shade800;
      break;
    case "Pleasant":
      return Colors.yellowAccent.shade400;
      break;
    case "Good":
      return Colors.lightGreenAccent;
      break;
    case "Very Good":
      return Colors.lightGreen.shade600;
      break;
    default:
      return Colors.cyanAccent;
      break;
  }
}


