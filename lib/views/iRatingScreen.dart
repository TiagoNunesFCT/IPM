import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/individualRObject.dart';
import 'package:zone/datatypes/userObject.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/widgets/starSelector.dart';
import 'package:zone/widgets/starShower.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

bool pressed = false;
bool clean = true;

List<IndividualR> listRating;
List<User> listUser;

class IRatingPage extends GenericPage {
//empty constructor, there isn't much we can do here

  Zone zone;

  IRatingPage(Zone zone) {
    this.zone = zone;
    listRating = [];
    listUser = [];
    clean = true;
  }

  @override
  _IRatingPageState createState() => new _IRatingPageState(zone);
}

class _IRatingPageState extends GenericPageState {
  Zone zone;

  _IRatingPageState(Zone zone) {
    this.zone = zone;
  }

  @override
  void initState() {
    setState(() {
      if (clean) {
        getIndivRatings();
        getUsers();
        clean = false;
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget page;

    page = Scaffold(
        appBar: new AppBar(
          title: new Text(
            zone.zoneNam,
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
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                          itemCount: listRating.length,
                          itemBuilder: (context, position) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(2, 1, 2, 8),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black38,
                                  border: new Border.all(
                                    color: Colors.white12,
                                    width: 1.0,
                                  ),
                                ),
                                child: RatingContainer(listRating,position));
                          })),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 10), child: buttonBack.BackButton()), Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 10), child: addButton(zone))])
                ]))));
    return page;
  }

  Widget RatingContainer(List<IndividualR> list, int position) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.supervised_user_circle_rounded,
            color: const Color(0xFFD8DEE9), size: 30,),
          Text(
            (getUserFromId(list[position].indiRUId.toString()) != null) ? (getUserFromId(list[position].indiRUId.toString()).usrNam) : "Username",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 22,
              color: const Color(0xFFD8DEE9),
            ),
          )
        ]),
        Text(
          list[position].indiRTim,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 18,
            color: const Color(0xFFD8DEE9),
          ),
        )
      ]),
StarShower(list[position].indiRStr.toDouble()),
      Text(
        list[position].indiRDsc,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 18,
          color: const Color(0xFFD8DEE9),
        ),
      )
    ]);
  }

  Widget addButton(Zone zone) {
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

  void showAddDialog(Zone zone) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddRatingDialog(zone, updateState),
    );
  }

  void updateState() {
    setState(() {
      initState();
    });
  }

  Future<List<Map<String, dynamic>>> getIndivRatings() async {
    listRating = [];
    List<Map<String, dynamic>> listMap = (await DBHandler.instance.querySpecificIRatings(zone.zoneId.toString()));
    setState(() {
      listMap.forEach((map) => listRating.add(IndividualR.fromMap(map)));
      debugPrint("did that");
      debugPrint("listposts size " + listRating.length.toString());
    });
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    listUser = [];
    List<Map<String, dynamic>> listMap = (await DBHandler.instance.queryAllRowsUsers());
    setState(() {
      listMap.forEach((map) => listUser.add(User.fromMap(map)));
      debugPrint("did that");
      debugPrint("listuser size " + listUser.length.toString());
    });
  }

  User getUserFromId(String userId) {
    for (User u in listUser) {
      if (u.usrId.toString() == userId) {
        return u;
      }
    }
    return null;
  }

}

class AddRatingDialog extends StatefulWidget {
  Zone zone;
  void Function() callback;
  int zoneId;
  int userId;


  AddRatingDialog(Zone zone,void Function() callback) {
    this.zone = zone;
    zoneId = zone.zoneId;
    userId = 0;
    this.callback = callback;
  }

  _AddRatingDialogState createState() => new _AddRatingDialogState(callback);
}

class _AddRatingDialogState extends State<AddRatingDialog> {
  void Function() callback;
  _AddRatingDialogState(void Function() callback){
    this.callback = callback;
  }

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
                  color: const Color(0xFFD8DEE9),
                  //Color(0xFFE97553), old color, nicer looking
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0),
            ),
          ),
          new TextButton(
            onPressed: () {
              if (rateFeedback.text.isNotEmpty) {
                IndividualR ratingToBeAdded = new IndividualR(indiRZone: widget.zoneId, indiRUId: widget.userId, indiRStr: starSel.getStars(), indiRDsc: rateFeedback.text, indiRTim: "25/12/2023");
                DBHandler.instance.insertIndividualR(ratingToBeAdded.toMapWithoutId());
                debugPrint("Got these stars: " + starSel.getStars().toString());
                clean = true;
                Navigator.of(context).pop();
                SystemChrome.setEnabledSystemUIOverlays([]);
                setState(() {
                  callback();
                });
              }
            },
            child: Text(
              'Publish',
              style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 16.0),
            ),
          ),
        ])
      ],
    )));
  }
}
