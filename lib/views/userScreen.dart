import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

import 'genericPage.dart';

// ignore: must_be_immutable
class UserPage extends GenericPage {
  //empty constructor, there isn't much we can do here
  UserPage();

  @override
  _UserPageState createState() => new _UserPageState();
}

class _UserPageState extends GenericPageState {
  @override
  void initState() {
    super.initState();
  }

  String userName = "Username";
  String zoneName = "Laranjeiro e Feijó";
  String cityName = "Almada";
  String countryName = "🇵🇹";
  String userDesc = "Hi! I just started using this App!\nBeen having a lot of fun!!! 🤓♿🤪";

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 10),Column(mainAxisSize: MainAxisSize.max, children: [
            IconButton(
                iconSize: 240,
                icon: Stack(alignment: Alignment.center, children: [
                  Icon(
                    Icons.circle,
                    color: Colors.grey.shade400,
                    size: 240,
                  ),
                  Icon(
                    Icons.supervised_user_circle_rounded,
                    color: Colors.grey.shade800,
                    size: 220,
                  )
                ]),
                onPressed: () {
                  /*
                              DatabaseHelper.instance
                                  .delete(getWaypoint.waypId);
                              setState(() => {
                                    listWaypoints.removeWhere((item) =>
                                        item.waypId == getWaypoint.waypId)
                                  });
                            */
                }),
            Row(mainAxisSize: MainAxisSize.min, children: [              IconButton(
              icon: Icon(CupertinoIcons.pencil_circle),
              onPressed: () {widget.showToast();},
              iconSize: 40,
              color: const Color(0xFF1D1D1D),
            ),
              Text(
                userName,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(CupertinoIcons.pencil_circle),
                onPressed: () {
                  widget.showToast();
                },
                iconSize: 40,
                color: Colors.white,
              )
            ])
          ]),
          Container(margin:EdgeInsets.fromLTRB(10, 0, 10, 5),padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              height:250,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Colors.black38,
                border: new Border.all(
                  color: Colors.white12,
                  width: 1.0,
                ),
              ),
              child: SingleChildScrollView(child:Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Zone:",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: Colors.orange.shade400,
                      )),
                  Text(zoneName,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: const Color(0xFFD8DEE9),
                      ))
                ]),Container(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("City:",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: Colors.orange.shade400,
                      )),
                  Text(cityName,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: const Color(0xFFD8DEE9),
                      ))
                ]),Container(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Country:",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: Colors.orange.shade400,
                      )),
                  Text(countryName,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 24,
                        color: const Color(0xFFD8DEE9),
                      ))
                ]),Container(height: 5),
                Text("About Me:",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24,
                      color: Colors.orange.shade400,
                    )),Container(height: 5),
                Text(userDesc,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: const Color(0xFFD8DEE9),
                    ))
              ])))
            ,Row(children:[Container(margin:EdgeInsets.fromLTRB(10, 0, 10, 10),child:buttonBack.BackButton())])],
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
