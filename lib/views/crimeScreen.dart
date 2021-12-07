import 'package:flutter/material.dart';

import 'genericPage.dart';

class CrimePage extends GenericPage {

  String zone;

//empty constructor, there isn't much we can do here
  CrimePage(String zone){
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