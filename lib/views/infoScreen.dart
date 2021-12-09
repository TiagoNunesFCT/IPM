import 'package:flutter/material.dart';

import 'genericPage.dart';

String infoZone = "Laranjeiro e Feijó";

class InfoPage extends GenericPage {
  String zone;
  String type;

//empty constructor, there isn't much we can do here
  InfoPage(String zone, String type) {
    this.zone = zone;
    this.type = type;
  }

  @override
  _InfoPageState createState() => new _InfoPageState(zone, type);
}

class _InfoPageState extends GenericPageState {
  String zone;
  String type;

  _InfoPageState(this.zone, this.type);

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            zone,
            style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: Row(children: [
            Container(
              child: Row(children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: getInfoIcon(type),
                  ),
                ),
              ]),
            ),
          ]),
          elevation: 0,
          backgroundColor: const Color(0xFF1D1D1D),
          foregroundColor: Colors.black,
          actions: [
            Container(),
          ],
        ),
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF1D1D1D),
                child: Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black38,
                      border: new Border.all(
                        color: Colors.white12,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                        ]))))); //TODO Return your hierarchy
  }

  Widget getInfoIcon(String type) {
    switch (type.toLowerCase()) {
      case "prices":
        return Icon(
          Icons.attach_money_rounded,
          size: 30,
          color: Colors.white,
        );
        break;
      case "service":
        return Column(children: [
          Icon(Icons.account_balance_rounded, color: Colors.white, size: 15),
          Icon(
            Icons.directions_bus_outlined,
            size: 15,
            color: Colors.white,
          ),
        ]);
        break;
      case "shopping":
        return Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 40);
        break;
      case "tourism":
        return Column(children: [
          Icon(Icons.beach_access_outlined, color: Colors.white, size: 15),
          Icon(
            Icons.attractions,
            size: 15,
            color: Colors.white,
          ),
        ]);
        break;
    }
  }
}
