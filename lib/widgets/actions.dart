//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/views/MainScreen.dart';
import 'package:zone/views/iRatingScreen.dart';
import 'package:zone/views/infoMenuScreen.dart';
import 'package:zone/views/locationScreen.dart';
import 'package:zone/views/postScreen.dart';

class ActionButton extends StatefulWidget {

  String currentZone;

  Zone currentZoneOb;

  ActionButton(Zone currentZoneOb) {
    this.currentZoneOb = currentZoneOb;
  }


  ActionButtonState createState() => new ActionButtonState();

}

class ActionButtonState extends State<ActionButton> {



  Widget ratingsButton(BuildContext context) {
    return Column(children:[Container(height: 70, width:70,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: Colors.black38,
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),child:IconButton(
      icon: Icon(Icons.star_outline_rounded, color: Colors.white, size: 45),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IRatingPage(widget.currentZoneOb)),
        );
      },
    )), Text("Ratings",style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  Widget infoButton(BuildContext context) {
    return Column(children:[Container(height: 70, width:70,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: Colors.black38,
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),child:IconButton(
      icon: Icon(Icons.info_outline_rounded, color: Colors.white, size: 40),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoMenuPage(widget.currentZoneOb)),
        );
      },
    )), Text("Info",style: TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      color: Colors.white,
    ),)]);
  }

  Widget postsButton(BuildContext context) {
    return
      Column(children:[Container(height: 70, width:70,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    decoration: new BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5),
    color: Colors.black38,
    border: new Border.all(
    color: Colors.white12,
    width: 1.0,
    ),
    ),child:IconButton(
      icon: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 40),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostPage(widget.currentZoneOb)),
        );
      },
    )), Text("Posts",style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  @override
  Widget build(BuildContext context) {
    return
        Row(mainAxisSize: MainAxisSize.min, children: [ratingsButton(context),Container(width:30),infoButton(context),Container(width:30),postsButton(context)]);
  }

  /*Future<void> buttonPressing(String button) async {

    switch(button){
      case ("Home"):
        {    homePressed = true;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 10), () {});
        pressed = false;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 5), () {});}
        break;

    }

  }*/


}
