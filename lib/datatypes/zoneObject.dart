import 'package:flutter/cupertino.dart';

//This class represents a Zone object
class Zone {
  //The Current Zone Attributes
  int zoneId;
  double zoneLat, zoneLon;
  String zoneNam, zoneCtr, zoneCty;

  Zone({this.zoneId, @required this.zoneNam, @required this.zoneLat, @required this.zoneLon, @required this.zoneCtr, @required this.zoneCty});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["zon_name"] = zoneNam;
    map["zon_lat"] = zoneLat;
    map["zon_lon"] = zoneLon;
    map["zon:ctr"] = zoneCtr;
    map["zon_cty"] = zoneCty;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["zon_id"] = zoneId;
    map["zon_name"] = zoneNam;
    map["zon_lat"] = zoneLat;
    map["zon_lon"] = zoneLon;
    map["zon:ctr"] = zoneCtr;
    map["zon_cty"] = zoneCty;
    return map;
  }

  //to be used when converting the row into object
  factory Zone.fromMap(Map<String, dynamic> data) => new Zone(
        zoneId: data['zon_id'],
        zoneNam: data['zon_name'],
        zoneLat: data['zon_lat'],
        zoneLon: data['zon_lon'],
        zoneCtr: data['zon_ctr'],
        zoneCty: data['zon_cty']
    );
}
