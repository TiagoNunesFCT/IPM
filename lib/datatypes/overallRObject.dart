import 'package:flutter/cupertino.dart';

//This class represents a Overall Rating object
class OverallR {
  //The Current OverallR Attributes
  int overRId, overRZon, overROne, overRTwo, overRTre, overRFor, overRFiv;

  OverallR({this.overRId, @required this.overRZon, @required this.overROne, @required this.overRTwo, @required this.overRTre, @required this.overRFor, @required this.overRFiv});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["ovrt_zone"] = overRZon;
    map["ovrt_one"] = overROne;
    map["ovrt_two"] = overRTwo;
    map["ovrt_tre"] = overRTre;
    map["ovrt_for"] = overRFor;
    map["ovrt_fiv"] = overRFiv;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["ovrt_id"] = overRId;
    map["ovrt_zone"] = overRZon;
    map["ovrt_one"] = overROne;
    map["ovrt_two"] = overRTwo;
    map["ovrt_tre"] = overRTre;
    map["ovrt_for"] = overRFor;
    map["ovrt_fiv"] = overRFiv;
    return map;
  }

  //to be used when converting the row into object
  factory OverallR.fromMap(Map<String, dynamic> data) => new OverallR(
      overRId: data['ovrt_id'],
      overRZon: data['ovrt_zone'],
      overROne: data['ovrt_one'],
      overRTwo: data['ovrt_two'],
      overRTre: data['ovrt_tre'],
      overRFor: data['ovrt_for'],
      overRFiv: data['ovrt_fiv']
    );
}
