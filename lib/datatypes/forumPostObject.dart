import 'package:flutter/cupertino.dart';

//This class represents a Forum Post object
class ForumPost{
  //The Current Forum Post Attributes
  int forumId, forumZone, forumUId, forumIsR;

  String forumTtl, forumDsc, forumRep, forumTst;

  ForumPost({this.forumId, @required this.forumZone, @required this.forumUId, @required this.forumTtl, @required this.forumDsc, @required this.forumRep, @required this.forumTst, @required this.forumIsR});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["frum_zone"] = forumZone;
    map["frum_uid"] = forumUId;
    map["frum_ttl"] = forumTtl;
    map["frum_dsc"] = forumDsc;
    map["frum_rpl"] = forumRep;
    map["frum_tst"] = forumTst;
    map["frum_isr"] = forumIsR;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["frum_id"] = forumId;
    map["frum_zone"] = forumZone;
    map["frum_uid"] = forumUId;
    map["frum_ttl"] = forumTtl;
    map["frum_dsc"] = forumDsc;
    map["frum_rpl"] = forumRep;
    map["frum_tst"] = forumTst;
    map["frum_isr"] = forumIsR;
    return map;
  }

  //to be used when converting the row into object
  factory ForumPost.fromMap(Map<String, dynamic> data) => new ForumPost(
      forumId: data['frum_id'],
      forumZone: data['frum_zone'],
      forumUId: data['frum_uid'],
      forumTtl: data['frum_ttl'],
      forumDsc: data['frum_dsc'],
      forumRep: data['frum_rpl'],
      forumTst: data['frum_tst'],
      forumIsR: data['frum_isr']
  );
}
