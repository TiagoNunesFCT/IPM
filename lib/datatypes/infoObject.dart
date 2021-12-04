import 'package:flutter/cupertino.dart';

//This class represents a piece of information about a zone
class Info {
  //The Current Waypoint Attributes
  int infoId, infoZone;
  String infoNam, infoTyp, infoVal;

  Info({this.infoId, @required this.infoZone, @required this.infoTyp, @required this.infoNam, @required this.infoVal});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["info_zone"] = infoZone;
    map["info_type"] = infoTyp;
    map["info_name"] = infoNam;
    map["info_val"] = infoVal;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["info_id"] = infoId;
    map["info_zone"] = infoZone;
    map["info_type"] = infoTyp;
    map["info_name"] = infoNam;
    map["info_val"] = infoVal;
    return map;
  }

  //to be used when converting the row into object
  factory Info.fromMap(Map<String, dynamic> data) => new Info(
      infoId: data['info_id'],
      infoZone: data['info_zone'],
      infoTyp: data['info_type'],
      infoNam: data['info_name'],
      infoVal: data['info_val']
  );
}
