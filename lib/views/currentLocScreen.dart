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

  String zoneName = "Laranjeiro e Feijó";
  String cityName = "Almada";
  String zoneQuality = "Average";
  String zoneRanking = "(47th)";

  //Build the widget
  @override
  Widget build(BuildContext context) {
    Widget page = Scaffold(appBar: new AppBar(
      leading:Container(
        child: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.supervised_user_circle_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
      body:Center(
      child: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1D1D1D),
      child:Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Column(children:[Text(
        'Current Zone:',
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 24,
          color: Colors.white,
        ),
      ),Container(      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          border: new Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),child:Text(
        zoneName,
        style: TextStyle(
          fontFamily: "Nasalization",
          color: (ratingToColor(zoneQuality)),
          fontSize: 24,
        ),
      ),)]),Text(
        'City: '+cityName,
        style: TextStyle(
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
      ),Text(
        zoneQuality+' '+zoneRanking,
        style: TextStyle(
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
      ),],),))
    );
    return page;
  }



}

Color ratingToColor(String color){
  switch (color){
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


