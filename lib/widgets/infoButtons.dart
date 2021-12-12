//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/views/MainScreen.dart';
import 'package:zone/views/crimeScreen.dart';
import 'package:zone/views/infoMenuScreen.dart';
import 'package:zone/views/infoScreen.dart';
import 'package:zone/views/locationScreen.dart';



class InfoButton extends StatefulWidget {

  Zone zone;

  bool pricePressed;
  bool servicesPressed;
  bool shoppingPressed;
  bool tourismPressed;
  bool crimePressed;

  InfoButton(Zone zone) {
    this.zone = zone;
    this.pricePressed = false;
    this.servicesPressed = false;
    this.shoppingPressed = false;
    this.tourismPressed = false;
    this.crimePressed = false;
  }

  InfoButtonState createState() => new InfoButtonState();
}

class InfoButtonState extends State<InfoButton> {
  Widget pricesButton(BuildContext context) {
    return Column(children:[Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.pricePressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.pricePressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.attach_money_rounded, color: Colors.green, size: 45),
          onPressed: () {
              buttonPressing("Prices");
          },
        )), Text("Prices\n",textAlign: TextAlign.center,style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  Widget serviceButton(BuildContext context) {
    return Column(children:[Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.servicesPressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.servicesPressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Column(children: [
            Icon(Icons.account_balance_rounded, color: Colors.yellow, size: 28),
            Icon(
              Icons.directions_bus_outlined,
              size: 28,
              color: Colors.yellow,
            ),
          ]),
          onPressed: () {
            buttonPressing("Services");
          },
        )), Text("Services\nTransport",textAlign: TextAlign.center,style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  Widget shoppingButton(BuildContext context) {
    return Column(children:[Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.shoppingPressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.shoppingPressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.pink, size: 40),
          onPressed: () {
            buttonPressing("Shopping");
          },
        )), Text("Shops\n",textAlign: TextAlign.center,style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  Widget tourismButton(BuildContext context) {
    return Column(children:[Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: (widget.tourismPressed) ? Colors.white12 :Colors.black38,
          border: new Border.all(
            color: (!widget.tourismPressed) ? Colors.white12 : Colors.white,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Column(children: [
            Icon(Icons.beach_access_outlined, color: Colors.blue, size: 28),
            Icon(
              Icons.attractions,
              size: 28,
              color: Colors.blue,
            ),
          ]),
          onPressed: () {
            buttonPressing("Tourism");
          },
        )), Text("Tourism\nLeisure",textAlign: TextAlign.center,style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  Widget crimeButton(BuildContext context) {
    return Column(children:[Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: ratingToColor(zoneQuality), //this Color must depend on the crime rating of the zone
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.warning_amber_rounded, color: Colors.black, size: 45),
          onPressed: () {
            buttonPressing("Crime");
            /**
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CrimePage(widget.zone)),
            );*/
          },
        )), Text("Crime\nNews",style: TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    color: Colors.white,
    ),)]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisSize: MainAxisSize.min, children: [pricesButton(context), Container(width: 30), serviceButton(context), Container(width: 30), shoppingButton(context)]),
      Container(height: 30),
      Row(mainAxisSize: MainAxisSize.min, children: [tourismButton(context), Container(width: 30), crimeButton(context)])
    ]);
  }

  Future<void> buttonPressing(String button) async {
    switch (button) {
      case ("Prices"):
        {
          widget.pricePressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.pricePressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Prices")),
          );
        }
        break;
      case ("Services"):
        {
          widget.servicesPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.servicesPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Service")),
          );

        }
        break;
      case ("Shopping"):
        {
          widget.shoppingPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.shoppingPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Shopping")),
          );
        }
        break;
      case ("Tourism"):
        {
          widget.tourismPressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.tourismPressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage(widget.zone, "Tourism")),
          );
        }
        break;
      case ("Crime"):
        {
          widget.crimePressed = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          widget.crimePressed = false;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 10), () {});
          showToast();
        }
        break;
    }
  }

}

void showToast(){
  Fluttertoast.showToast(msg: "Functionality not Available in this Prototype", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
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