import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/individualRObject.dart';
import 'package:zone/widgets/starSelector.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

bool pressed = false;

class IRatingPage extends GenericPage {
//empty constructor, there isn't much we can do here

  String zone;

  IRatingPage(String zone) {
    this.zone = zone;
  }

  @override
  _IRatingPageState createState() => new _IRatingPageState(zone);
}

class _IRatingPageState extends GenericPageState {
  String zone;

  _IRatingPageState(String zone) {
    this.zone = zone;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget page;

    page = Scaffold(
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
                    icon: Icon(
                      Icons.star_border_rounded,
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
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 500,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black38,
                        border: new Border.all(
                          color: Colors.white12,
                          width: 1.0,
                        ),
                      ),
                      child: ListView.builder(
                          itemCount: 35,
                          itemBuilder: (context, position) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black38,
                                  border: new Border.all(
                                    color: Colors.white12,
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  position.toString(),
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ));
                          })),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()), Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: addButton(zone))])
                ]))));
    return page;
  }

  Widget addButton(String zone) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          color: pressed ? Colors.white12 : Colors.black38,
          border: new Border.all(
            color: Colors.white12,
            width: 1.0,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.add_rounded, color: (pressed) ? Colors.white12 : Colors.white, size: 30),
          onPressed: () {
            buttonPressing();
            showAddDialog(zone);
          },
        ));
  }

  Future<void> buttonPressing() async {
    debugPrint("ButtonPressed");
    pressed = true;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 10), () {});
    pressed = false;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 5), () {});
  }

  void showAddDialog(String zone) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddRatingDialog(zone),
    );
  }
}

class AddRatingDialog extends StatefulWidget {
  String zone;

  int zoneId;
  int userId;

  //TODO Get zone object and extract the zoneId in order to store it. Do a similar thing for the userId (the username is given somewhere, I think, otherwise just store the current user on the commonPage)

  AddRatingDialog(String zone) {
    this.zone = zone;
    zoneId = 0;
    userId = 0;
  }

  _AddRatingDialogState createState() => new _AddRatingDialogState();
}

class _AddRatingDialogState extends State<AddRatingDialog> {
  _AddRatingDialogState();

  TextEditingController rateFeedback = new TextEditingController(text: "Feedback");

  StarSelector starSel = new StarSelector();

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: SingleChildScrollView(
            child: AlertDialog(
      backgroundColor: const Color(0xFF1D1D1D),
      title: Text(
        "Leave a Rating",
        style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 18.0),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Rating:",
            style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 14.0),
          ),
          starSel,
          SizedBox(height: 5),
          Text(
            "Feedback:",
            style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 14.0),
          ),
          SizedBox(height: 5),
          Container(
              height: 200,
              child: TextField(
                maxLines: 99,
                controller: rateFeedback,
                keyboardType: TextInputType.multiline,
                selectionControls: desktopTextSelectionControls,
                cursorColor: Colors.white12,
                style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 20.0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white12, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30, width: 1.0),
                  ),
                ),
              )),
        ],
      ),
      actions: <Widget>[
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          new TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              SystemChrome.setEnabledSystemUIOverlays([]);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  //Color(0xFFE97553), old color, nicer looking
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0),
            ),
          ),
          new TextButton(
            onPressed: () {
              if (rateFeedback.text.isNotEmpty) {
                IndividualR ratingToBeAdded = new IndividualR(indiRZone: widget.zoneId, indiRUId: widget.userId, indiRStr: starSel.getStars(), indiRDsc: rateFeedback.text, indiRTim: "20/4/1977");
                DBHandler.instance.insertIndividualR(ratingToBeAdded.toMapWithoutId());
                debugPrint("Got these stars: " + starSel.getStars().toString());
                Navigator.of(context).pop();
                SystemChrome.setEnabledSystemUIOverlays([]);
              }
            },
            child: Text(
              'Publish',
              style: TextStyle(fontFamily: "Montserrat", color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
            ),
          ),
        ])
      ],
    )));
  }
}
