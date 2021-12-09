import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/forumPostObject.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

bool pressed = false;

class PostPage extends GenericPage {
//empty constructor, there isn't much we can do here

  String zone;
  String ogId;

  PostPage(String zone) {
    this.zone = zone;
    ogId = null;
  }

  PostPage.isReply(String zone, String ogId) {
    this.zone = zone;
    this.ogId = ogId;
  }

  @override
  _PostPageState createState() => new _PostPageState(zone, ogId);
}

class _PostPageState extends GenericPageState {
  String zone;
  String ogId;

  _PostPageState(String zone, String ogId) {
    this.zone = zone;
    this.ogId = ogId;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget page;
    (ogId == null)? {
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
                              Icons.chat_bubble_outline_rounded,
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
                      child:Column(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[Container(
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
                                    child:Text(position.toString(),style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),));
                              })), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()),Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child:addButton("normal", zone, ogId))])])
                )))
          }
        : {page = Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Replies",
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
                child:Column(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[Container(
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
                              child:Text(position.toString(),style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 30,
                                color: Colors.white,
                              ),));
                        })), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()),Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child:addButton("normal", zone, ogId))])])
            )))};
    return page;
  }

  Widget addButton(String mode, String zone, String ogId) {




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
        child:IconButton(
      icon: Icon(Icons.add_rounded, color: (pressed) ? Colors.white12 : Colors.white, size: 30),
      onPressed: () {
        buttonPressing();
        showAddDialog(mode, zone, ogId);
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

  void showAddDialog(String mode, String zone, String ogId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddPostDialog(mode, zone, ogId),
    );
  }
}


class AddPostDialog extends StatefulWidget{



  String mode;
  String zone;
  String OgId;
  int zoneId;
  int userId;

  //TODO Get zone object and extract the zoneId in order to store it. Do a similar thing for the userId (the username is given somewhere, I think, otherwise just store the current user on the commonPage)

  AddPostDialog(String mode, String zone, String OgId){
  this.mode = mode;
  this.zone = zone;
  this.OgId = OgId;
  zoneId = 0;
  userId = 0;
  }


  _AddPostDialogState createState() => new _AddPostDialogState();



}

class _AddPostDialogState extends State<AddPostDialog>{

  _AddPostDialogState();

  TextEditingController postTtl = new TextEditingController(text: "Title");
  TextEditingController postDesc = new TextEditingController(text: "Description");


  @override
  Widget build(BuildContext context) {

    return new Center(
        child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: const Color(0xFF1D1D1D),
              title:  Text(
                (widget.mode == "reply")? "Reply to Post":"Add Post",
                style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 18.0),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title:",
                    style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 14.0),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: postTtl,
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
                  ),

                  Text(
                    "Description:",
                    style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 14.0),
                  ),
                  SizedBox(height: 5),
                  Container(height: 200,child:TextField(maxLines: 99,
                    controller: postDesc,
                    keyboardType: TextInputType.multiline,
                    selectionControls: desktopTextSelectionControls,
                    cursorColor: const Color(0xFF8FBCBB),
                    style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 20.0),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade700, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade700, width: 1.0),
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
                          color: const Color(0xFF8FBCBB),
                          //Color(0xFFE97553), old color, nicer looking
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0),
                    ),
                  ),
                  new TextButton(
                    onPressed: () {
                      if (postDesc.text.isNotEmpty) {
                        var postDescription = postDesc.text;
                        ForumPost postToBeAdded = new ForumPost(forumZone: widget.zoneId,forumUId: widget.userId,forumTtl: postTtl.text, forumDsc: postDesc.text, forumRep: (widget.mode=="reply")? widget.OgId:"", forumTst: "20/4/1977", forumIsR:  (widget.mode=="reply")? 1: 0);
                        DBHandler.instance.insertForums(postToBeAdded.toMapWithoutId());
                        Navigator.of(context).pop();
                        SystemChrome.setEnabledSystemUIOverlays([]);
                      }
                    },
                    child: Text(
                      'Publish',
                      style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFF8FBCBB), fontWeight: FontWeight.w300, fontSize: 16.0),
                    ),
                  ),
                ])
              ],
            )));
  }

}


