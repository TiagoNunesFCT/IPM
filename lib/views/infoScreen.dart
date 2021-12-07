import 'package:flutter/material.dart';

import 'genericPage.dart';

String infoZone = "Laranjeiro e Feijó";

class InfoPage extends GenericPage {
  String zone;
  String type;

//empty constructor, there isn't much we can do here
  InfoPage(String zone, String type) {
    this.zone = zone;
    this.type = type;
  }

  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends GenericPageState {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(); //TODO Return your hierarchy
  }
}
