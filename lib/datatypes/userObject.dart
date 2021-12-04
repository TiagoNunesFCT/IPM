import 'package:flutter/cupertino.dart';

//This class represents a User object
class User {
  //The Current User Attributes
  int usrId;

  String usrNam, usrCtr, usrCty, usrZne, usrDsc, usrFnd, usrImg, usrTyp;

  User({this.usrId, @required this.usrNam, @required this.usrCtr, @required this.usrCty, @required this.usrZne, @required this.usrDsc, @required this.usrFnd, @required this.usrImg, @required this.usrTyp});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["usr_name"] = usrNam;
    map["usr_ctr"] = usrCtr;
    map["usr_cty"] = usrCty;
    map["usr_zne"] = usrZne;
    map["usr_desc"] = usrDsc;
    map["usr_frnd"] = usrFnd;
    map["usr_img"] = usrImg;
    map["usr_typ"] = usrTyp;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["usr_id"] = usrId;
    map["usr_name"] = usrNam;
    map["usr_ctr"] = usrCtr;
    map["usr_cty"] = usrCty;
    map["usr_zne"] = usrZne;
    map["usr_desc"] = usrDsc;
    map["usr_frnd"] = usrFnd;
    map["usr_img"] = usrImg;
    map["usr_typ"] = usrTyp;
    return map;
  }

  //to be used when converting the row into object
  factory User.fromMap(Map<String, dynamic> data) => new User(
        usrId: data['usr_id'],
        usrNam: data['usr_name'],
        usrCtr: data['usr_ctr'],
        usrCty: data['usr_cty'],
        usrZne: data['usr_zne'],
        usrDsc: data['user_desc'],
        usrFnd: data['usr_frnd'],
        usrImg: data['usr_img'],
        usrTyp: data['usr_typ']
    );
}
