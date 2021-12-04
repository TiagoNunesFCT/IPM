import 'package:flutter/cupertino.dart';

//This class represents a Crime News object
class CrimeN {
  //The Current CrimeN Attributes
  int crimeNId, crimeNZone;

  String crimeNNam, crimeNLogo, crimeNDsc, crimeNHyp, crimeNTst;

  CrimeN({this.crimeNId, @required this.crimeNZone, @required this.crimeNNam, @required this.crimeNLogo, @required this.crimeNDsc, @required this.crimeNHyp, @required this.crimeNTst});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["crim_zone"] = crimeNZone;
    map["crim_name"] = crimeNNam;
    map["crim_logo"] = crimeNLogo;
    map["crim_dsc"] = crimeNDsc;
    map["crim_hyp"] = crimeNHyp;
    map["crim_tst"] = crimeNTst;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["crim_id"] = crimeNId;
    map["crim_zone"] = crimeNZone;
    map["crim_name"] = crimeNNam;
    map["crim_logo"] = crimeNLogo;
    map["crim_dsc"] = crimeNDsc;
    map["crim_hyp"] = crimeNHyp;
    map["crim_tst"] = crimeNTst;
    return map;
  }

  //to be used when converting the row into object
  factory CrimeN.fromMap(Map<String, dynamic> data) => new CrimeN(
      crimeNId: data['crim_id'],
      crimeNZone: data['crim_zone'],
      crimeNNam: data['crim_name'],
      crimeNLogo: data['crim_logo'],
      crimeNDsc: data['crim_dsc'],
      crimeNHyp: data['crim_hyp'],
      crimeNTst: data['crim_tst']
  );
}
