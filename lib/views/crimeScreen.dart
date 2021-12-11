import 'package:flutter/material.dart';
import 'package:zone/datatypes/zoneObject.dart';

import 'genericPage.dart';

class CrimePage extends GenericPage {

  Zone zone;

//empty constructor, there isn't much we can do here
  CrimePage(Zone zone){
    this.zone = zone;
  }

@override
_CrimePageState createState() => new _CrimePageState();
}

class _CrimePageState extends GenericPageState {
  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    return null; //TODO Return your hierarchy
  }
}