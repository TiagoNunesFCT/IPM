import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/forumPostObject.dart';
import 'package:zone/datatypes/userObject.dart';
import 'package:zone/datatypes/zoneObject.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

bool pressed = false;
bool clean = true;

List<ForumPost> listPost;
List<User> listUser;

class PostPage extends GenericPage {
//empty constructor, there isn't much we can do here

  Zone zone;
  String ogId;

  PostPage(Zone zone) {
    listPost = [];
    listUser = [];
    this.zone = zone;
    ogId = null;
    clean = true;
  }

  PostPage.isReply(Zone zone, String ogId) {
    this.zone = zone;
    this.ogId = ogId;
  }

  @override
  _PostPageState createState() => new _PostPageState(zone, ogId);
}

class _PostPageState extends GenericPageState {
  Zone zone;
  String ogId;

  _PostPageState(Zone zone, String ogId) {
    this.zone = zone;
    this.ogId = ogId;
  }

  @override
  void initState() {
    setState(() {
      if (clean) {
        getPosts();
        getUsers();
        clean = false;
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget page;
    (ogId == null)
        ? page = Scaffold(
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
                              itemCount: listPost.length,
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
                                    child: PostContainer(listPost, position));
                              })),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()), Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: addButton("normal", zone, ogId))])
                    ]))))
        : page = Scaffold(
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
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: buttonBack.BackButton()), Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: addButton("normal", zone, ogId))])
                    ]))));
    return page;
  }

  Widget PostContainer(List<ForumPost> list, int position) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.supervised_user_circle_rounded,
              color: Colors.white, size: 30,),
          Text(
            (getUserFromId(list[position].forumUId.toString()) != null) ? (getUserFromId(list[position].forumUId.toString()).usrNam) : "Username",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 22,
              color: Colors.white,
            ),
          )
        ]),
        Text(
          list[position].forumTst,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 22,
            color: Colors.white,
          ),
        )
      ]),
      Text(
        list[position].forumTtl,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      Text(
        list[position].forumDsc,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 18,
          color: Colors.white,
        ),
      )
    ]);
  }

  Widget addButton(String mode, Zone zone, String ogId) {
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

  void showAddDialog(String mode, Zone zone, String ogId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddPostDialog(mode, zone, ogId, updateState),
    );
  }

  void updateState() {
    setState(() {
      initState();
    });
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    listPost = [];
    List<Map<String, dynamic>> listMap = (await DBHandler.instance.querySpecificPosts(zone.zoneId.toString()));
    setState(() {
      listMap.forEach((map) => listPost.add(ForumPost.fromMap(map)));
      debugPrint("did that");
      debugPrint("listposts size " + listPost.length.toString());
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

class AddPostDialog extends StatefulWidget {
  void Function() callback;
  String mode;
  Zone zone;
  String OgId;
  int zoneId;
  int userId;


  AddPostDialog(String mode, Zone zone, String OgId, void Function() callback) {
    this.mode = mode;
    this.zone = zone;
    this.OgId = OgId;
    zoneId = zone.zoneId;
    userId = 0;
    this.callback = callback;
  }

  _AddPostDialogState createState() => new _AddPostDialogState(callback);
}

class _AddPostDialogState extends State<AddPostDialog> {
  void Function() callback;

  _AddPostDialogState(void Function() callback) {
    this.callback = callback;
  }

  TextEditingController postTtl = new TextEditingController(text: "Title");
  TextEditingController postDesc = new TextEditingController(text: "Description");

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: SingleChildScrollView(
            child: AlertDialog(
      backgroundColor: const Color(0xFF1D1D1D),
      title: Text(
        (widget.mode == "reply") ? "Reply to Post" : "Add Post",
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
          Container(
              height: 200,
              child: TextField(
                maxLines: 99,
                controller: postDesc,
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
              if (postDesc.text.isNotEmpty) {
                ForumPost postToBeAdded = new ForumPost(forumZone: widget.zoneId, forumUId: widget.userId, forumTtl: postTtl.text, forumDsc: postDesc.text, forumRep: (widget.mode == "reply") ? widget.OgId : "", forumTst: "25/12/2023", forumIsR: (widget.mode == "reply") ? 1 : 0);
                DBHandler.instance.insertForums(postToBeAdded.toMapWithoutId());
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
              style: TextStyle(fontFamily: "Montserrat", color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0),
            ),
          ),
        ])
      ],
    )));
  }
}
