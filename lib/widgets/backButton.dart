//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class BackButton extends StatefulWidget {
  bool pressed;
  BackButton() {
    pressed = false;
  }

  BackButtonState createState() => new BackButtonState();
}

class BackButtonState extends State<BackButton> {
  Widget icon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded, color: (widget.pressed) ? Colors.white12 : Colors.white, size: 30),
      onPressed: () {
        buttonPressing();

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: widget.pressed ? Colors.white12 : Colors.black38,
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
        child: icon(context));
  }

  Future<void> buttonPressing() async {
    widget.pressed = true;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 10), () {});
    widget.pressed = false;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 5), () {});
    Navigator.of(context).pop();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
