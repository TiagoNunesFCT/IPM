//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/MainScreen.dart';

class Rover extends StatelessWidget{

  bool hasHome;
  bool hasMap;
  bool hasList;
  List<Widget> buttonList;

  Rover(bool hasHome, bool hasMap, bool hasList){
    this.hasHome = hasHome;
    this.hasMap = hasMap;
    this.hasList = hasList;
  }



  Widget homeButton(BuildContext context){

    return IconButton(icon: Icon(Icons.house_rounded,color: Colors.white, size: 30), onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    },             );
  }
  Widget mapButton(BuildContext context){
    return IconButton(icon: Icon(Icons.map_rounded,color: Colors.white, size: 30), onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    },             );
  }

  Widget listButton(BuildContext context){
    return IconButton(icon: Icon(Icons.list_rounded,color: Colors.white, size: 30), onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    },             );
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
        ),child:Row(mainAxisSize: MainAxisSize.min,children:buttonList));
  }

  void buttonListInit(BuildContext context) {
    buttonList = [];
    if (hasHome){
      buttonList.add(homeButton(context));
    }
    if (hasMap){
      buttonList.add(mapButton(context));
    }
    if (hasList){
      buttonList.add(listButton(context));
    }
  }

}