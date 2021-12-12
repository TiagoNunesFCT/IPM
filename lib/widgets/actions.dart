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

  bool ratingPressed;
  bool infoPressed;
  bool postsPressed;

  ActionButton(Zone currentZoneOb) {
    this.currentZoneOb = currentZoneOb;
    this.ratingPressed = false;
    this.infoPressed = false;
    this.postsPressed = false;
  }


  ActionButtonState createState() => new ActionButtonState();

}

class ActionButtonState extends State<ActionButton> {



  Widget ratingsButton(BuildContext context) {
    return Column(children:[Container(height: 70, width:70,padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.ratingPressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.ratingPressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),child:IconButton(
      icon: Icon(Icons.star_outline_rounded, color: Colors.orange.shade600, size: 45),
      onPressed: () {
        buttonPressing("Ratings");
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
          color: (widget.infoPressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.infoPressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),child:IconButton(
      icon: Icon(Icons.info_outline_rounded, color: Colors.indigo, size: 40),
      onPressed: () {buttonPressing("Info");},
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
    color: (widget.postsPressed) ? Colors.white12 :Colors.black38,
    border: new Border.all(
    color: (!widget.postsPressed) ? Colors.white12 : Colors.white,
    width: 1.0,
    ),
    ),child:IconButton(
      icon: Icon(Icons.chat_bubble_outline_rounded, color: Colors.blueAccent, size: 40),
      onPressed: () {
        buttonPressing("Posts");
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

  Future<void> buttonPressing(String button) async {
    switch (button) {
      case ("Ratings"):
        {
          widget.ratingPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.ratingPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IRatingPage(widget.currentZoneOb)),
          );
        }
        break;
      case ("Info"):
        {
          widget.infoPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.infoPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoMenuPage(widget.currentZoneOb)),
          );

        }
        break;
      case ("Posts"):
        {
          widget.postsPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.postsPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage(widget.currentZoneOb)),
          );
        }
        break;
    }
  }


}
