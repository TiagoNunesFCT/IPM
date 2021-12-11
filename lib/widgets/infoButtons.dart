//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/views/MainScreen.dart';
import 'package:zone/views/crimeScreen.dart';
import 'package:zone/views/infoMenuScreen.dart';
import 'package:zone/views/infoScreen.dart';
import 'package:zone/views/locationScreen.dart';



class InfoButton extends StatefulWidget {

  Zone zone;

  InfoButton(Zone zone) {
    this.zone = zone;
  }

  InfoButtonState createState() => new InfoButtonState();
}

class InfoButtonState extends State<InfoButton> {
  Widget pricesButton(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
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
        child: IconButton(
          icon: Icon(Icons.attach_money_rounded, color: Colors.white, size: 45),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Prices")),
            );
          },
        ));
  }

  Widget serviceButton(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
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
        child: IconButton(
          icon: Column(children: [
            Icon(Icons.account_balance_rounded, color: Colors.white, size: 28),
            Icon(
              Icons.directions_bus_outlined,
              size: 28,
              color: Colors.white,
            ),
          ]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Service")),
            );
          },
        ));
  }

  Widget shoppingButton(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
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
        child: IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 40),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Shopping")),
            );
          },
        ));
  }

  Widget tourismButton(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
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
        child: IconButton(
          icon: Column(children: [
            Icon(Icons.beach_access_outlined, color: Colors.white, size: 28),
            Icon(
              Icons.attractions,
              size: 28,
              color: Colors.white,
            ),
          ]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Tourism")),
            );
          },
        ));
  }

  Widget crimeButton(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: Colors.black38, //this Color must depend on the crime rating of the zone
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 45),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CrimePage(widget.zone)),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisSize: MainAxisSize.min, children: [pricesButton(context), Container(width: 30), serviceButton(context), Container(width: 30), shoppingButton(context)]),
      Container(height: 30),
      Row(mainAxisSize: MainAxisSize.min, children: [tourismButton(context), Container(width: 30), crimeButton(context)])
    ]);
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
