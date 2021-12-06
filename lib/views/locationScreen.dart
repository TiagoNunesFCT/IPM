import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zone/widgets/actions.dart';
import 'package:zone/widgets/rover.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;
import 'package:zone/widgets/starShower.dart';

import 'genericPage.dart';

bool isCurrent;
// ignore: must_be_immutable
class LocPage extends GenericPage {


  //empty constructor, there isn't much we can do here
  LocPage(){
    isCurrent = false;
  }

  LocPage.currentLoc(){
    isCurrent = true;
  }

  @override
  _LocPageState createState() => new _LocPageState();
}

class _LocPageState extends GenericPageState {
  @override
  void initState() {
    super.initState();
  }

  String zoneName = "Laranjeiro e Feijó";
  String cityName = "Almada";
  String zoneQuality = "Average";
  String zoneRanking = "(47th)";
  String countryName = "🇵🇹";

  //Build the widget
  @override
  Widget build(BuildContext context) {
    Widget page = Scaffold(
        body: Center(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1D1D1D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(height: 80),
            Text(
              (isCurrent)?'Current Zone:':'Currently Viewing',
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Colors.black38,
                border: new Border.all(
                  color: Colors.white12,
                  width: 1.0,
                ),
              ),
              child: Text(
                zoneName,
                style: TextStyle(
                  fontFamily: "Nasalization",
                  color: (ratingToColor(zoneQuality)),
                  fontSize: 24,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    'City: ' + cityName,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    countryName,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                  ))
            ]),
          ]),
          Column(children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  transformAlignment: Alignment.topLeft,
                  alignment: Alignment.topLeft,
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.transparent,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      icon: Icon(
                        Icons.crop_square,
                        color: Colors.transparent,
                      ))),
              StarShower(0),
              Container(
                  transformAlignment: Alignment.topLeft,
                  alignment: Alignment.topLeft,
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.transparent,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      icon: Icon(
                        Icons.help_outline_rounded,
                        color: Colors.white12,
                      )))
            ]),
            Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(
                  zoneQuality + ' ' + zoneRanking,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                )),
          ]),ActionButton(),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()),
                Rover(true, false, false),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      border: new Border.all(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.transparent, size: 30),
                    ))
              ])),
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

String numberToRating(int rating) {
  switch (rating) {
    case 0:
    case 1:
      return "Horrible";
      break;
    case 2:
    case 3:
      return "Bad";
      break;
    case 4:
      return "Unpleasant";
      break;
    case 5:
      return "Average";
      break;
    case 6:
      return "Pleasant";
      break;
    case 7:
    case 8:
      return "Good";
      break;
    case 9:
    case 10:
      return "Very Good";
      break;
    default:
      return "None";
      break;
  }
}
