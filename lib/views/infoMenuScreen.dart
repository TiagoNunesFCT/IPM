import 'package:flutter/material.dart';
import 'package:zone/widgets/infoButtons.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;



class InfoMenuPage extends GenericPage {
//empty constructor, there isn't much we can do here
  InfoMenuPage();

  @override
  _InfoMenuPageState createState() => new _InfoMenuPageState();
}

class _InfoMenuPageState extends GenericPageState {

  String infoZone = "Laranjeiro e Feijó";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            infoZone,
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
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
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
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(alignment: Alignment.bottomCenter,height:80, child:Text("Information", style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 24,
                    color: Colors.white,
                  ),)),
                  InfoButton(infoZone),
                  Row(children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 10), child: buttonBack.BackButton())])
                ]))));
  }
}
