import 'package:flutter/cupertino.dart';

//This class represents a Individual Rating object
class IndividualR {
  //The Current IndividualR Attributes
  int indiRId, indiRZone, indiRUId, indiRStr;
  String indiRTim, indiRDsc;

  IndividualR({this.indiRId, @required this.indiRZone, @required this.indiRUId, @required this.indiRStr, @required this.indiRTim, @required this.indiRDsc});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["idrt_zone"] = indiRZone;
    map["idrt_uid"] = indiRUId;
    map["idrt_str"] = indiRStr;
    map["idrt_tst"] = indiRTim;
    map["idrt_dsc"] = indiRDsc;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["idrt_id"] = indiRId;
    map["idrt_zone"] = indiRZone;
    map["idrt_uid"] = indiRUId;
    map["idrt_str"] = indiRStr;
    map["idrt_tst"] = indiRTim;
    map["idrt_dsc"] = indiRDsc;
    return map;
  }

  //to be used when converting the row into object
  factory IndividualR.fromMap(Map<String, dynamic> data) => new IndividualR(
      indiRId: data['idrt_id'],
      indiRZone: data['idrt_zone'],
      indiRUId: data['idrt_uid'],
      indiRStr: data['idrt_str'],
      indiRTim: data['idrt_tst'],
      indiRDsc: data['idrt_dsc']
  );
}
