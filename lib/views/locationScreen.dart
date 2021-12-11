import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/overallRObject.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/widgets/actions.dart';
import 'package:zone/widgets/rover.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;
import 'package:zone/widgets/starShower.dart';

import 'genericPage.dart';

bool isCurrent;
bool started;

String zoneName;
String cityName;
double rating;
String zoneQuality;
String countryName;

Zone loc;
OverallR locRat;
// ignore: must_be_immutable
class LocPage extends GenericPage {

  int zoneId;

  //empty constructor, there isn't much we can do here
  LocPage(int zoneId){
    isCurrent = false;
    this.zoneId=zoneId;
    started = false;
    doStuff();
  }

  LocPage.currentLoc(){
    isCurrent = true;
    this.zoneId = currentLocId;
    started = false;
    doStuff();
  }

  void doStuff(){
    zoneName = "Loading...";
    cityName = "Loading...";
    rating = 3.0;
    zoneQuality = "Loading...";
    countryName = "Loading...";
    getZone(zoneId);
    getORating(zoneId);
  }

  @override
  _LocPageState createState() => new _LocPageState(zoneId);
}

class _LocPageState extends GenericPageState {
  @override
  int zoneId;

  _LocPageState(int zoneId){
    this.zoneId =zoneId;
  }

  void initState() {





    doStuff();
  }

  void doStuff() async{
    await getZone(zoneId);
    await getORating(zoneId);
    zoneName = loc.zoneNam;
    cityName = loc.zoneCty;
    countryName = loc.zoneCtr;
    rating = calculateRating(locRat);
    zoneQuality = numberToRating((rating*2).round());
    setState(() {

    });

    super.initState();
  }





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
              StarShower(rating),
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
                  zoneQuality,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                )),
          ]),ActionButton(loc),
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


Future<List<Map<String, dynamic>>> getZone(int zoneId) async{
  List<Map<String, dynamic>> listMap = await DBHandler.instance.queryAllRowsZones();
    listMap.forEach((map) => addToListZone(map, zoneId));

}

//Method that adds Waypoints to the List, in case they are compliant with the search criteria
addToListZone(Map<String, dynamic> map, int zoneId) {
  if (Zone.fromMap(map).zoneId == zoneId) {
    loc = (Zone.fromMap(map));
  }
}

 double calculateRating(OverallR locRat) {
  double result =  (locRat.overROne*1+locRat.overRTwo*2+locRat.overRTre*3+locRat.overRFor*4+locRat.overRFiv*3)/(locRat.overROne+locRat.overRTwo+locRat.overRTre+locRat.overRFor+locRat.overRFiv);

  return result;
}

Future<List<Map<String, dynamic>>> getORating(int zoneId) async{
  List<Map<String, dynamic>> listMap = await DBHandler.instance.queryAllRowsOverallR();
  listMap.forEach((map) => addToListRating(map, zoneId));

  zoneName = loc.zoneNam;
  cityName = loc.zoneCty;
  countryName = loc.zoneCtr;
  rating = calculateRating(locRat);
  zoneQuality = numberToRating((rating*2).round());
}

addToListRating(Map<String, dynamic> map, int zoneId) {
  debugPrint("zone ID we want"+zoneId.toString());
  debugPrint("zone ID we have on this particular object"+OverallR.fromMap(map).overRZon.toString());
  if (OverallR.fromMap(map).overRZon == zoneId) {
    locRat = (OverallR.fromMap(map));
    debugPrint("we found it");
  }
}

