//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/views/MainScreen.dart';
import 'package:zone/views/listScreen.dart';
import 'package:zone/views/mapScreen.dart';

class Rover extends StatefulWidget {
  bool hasHome;
  bool hasMap;
  bool hasList;
  bool homePressed;
  bool mapPressed;
  bool listPressed;
  String current;
  List<Widget> buttonList;

  Rover(bool hasHome, bool hasMap, bool hasList, String current) {
    this.hasHome = hasHome;
    this.hasMap = hasMap;
    this.hasList = hasList;
    this.homePressed = false;
    this.mapPressed = false;
    this.listPressed = false;
    this.current = current;
  }

  RoverState createState() => new RoverState();
}

class RoverState extends State<Rover> {
  Widget homeButton(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.homePressed || widget.current.toLowerCase() == "home") ? Colors.white12 : Colors.transparent,
        ),
        child: IconButton(
          icon: Icon(Icons.house_rounded, color: (widget.homePressed || widget.current.toLowerCase() == "home") ? Colors.white12 : Colors.white, size: 30),
          onPressed: () {
            (widget.current.toLowerCase() == "home")?debugPrint("User is trying to access the page they're on"):buttonPressing("Home");

          },
        ));
  }

  Widget mapButton(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.mapPressed || widget.current.toLowerCase() == "map") ? Colors.white12 : Colors.transparent,
        ),
        child: IconButton(
          icon: Container(child: Icon(Icons.map_rounded, color: (widget.mapPressed || widget.current.toLowerCase() == "map") ? Colors.white12 : Colors.white, size: 30)),
          onPressed: () {
            (widget.current.toLowerCase() == "map")?debugPrint("User is trying to access the page they're on"):buttonPressing("Map");

          },
        ));
  }

  Widget listButton(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.listPressed || widget.current.toLowerCase() == "list") ? Colors.white12 : Colors.transparent,
        ),
        child: IconButton(
          icon: Container(child: Icon(Icons.list_rounded, color: (widget.listPressed || widget.current.toLowerCase() == "list") ? Colors.white12 : Colors.white, size: 30)),
          onPressed: () {
            (widget.current.toLowerCase() == "list")?debugPrint("User is trying to access the page they're on"):buttonPressing("List");

          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    buttonListInit(context);
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: Colors.black38,
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: widget.buttonList));
  }

  void buttonListInit(BuildContext context) {
    widget.buttonList = [];
    if (widget.hasHome) {
      widget.buttonList.add(homeButton(context));
    }
    if (widget.hasMap) {
      widget.buttonList.add(mapButton(context));
    }
    if (widget.hasList) {
      widget.buttonList.add(listButton(context));
    }
  }

  Future<void> buttonPressing(String button) async {
    switch (button) {
      case ("Home"):
        {
          widget.homePressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.homePressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
        break;
      case ("Map"):
        {
          widget.mapPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.mapPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        }
        break;
      case ("List"):
        {
          widget.listPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.listPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListPage()),
          );
        }
        break;
    }
  }
}
