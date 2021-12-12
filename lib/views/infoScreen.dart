import 'package:flutter/material.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/infoObject.dart';
import 'package:zone/datatypes/zoneObject.dart';

import 'genericPage.dart';
import 'package:zone/widgets/backButton.dart' as buttonBack;

String infoZone = "Laranjeiro e Feijó";

List<Info> listInfo;
bool clean = true;

class InfoPage extends GenericPage {
  Zone zone;
  String type;

//empty constructor, there isn't much we can do here
  InfoPage(Zone zone, String type) {
    listInfo = [];
    this.zone = zone;
    this.type = type;
    clean = true;
  }

  @override
  _InfoPageState createState() => new _InfoPageState(zone, type);
}

class _InfoPageState extends GenericPageState {
  Zone zone;
  String type;
  List<Info> specificInfo;

  _InfoPageState(this.zone, this.type);

  @override
  void initState() {
    setState(() {
      if (clean) {
        getInfo();
        clean = false;
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            zone.zoneNam,
            style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: Row(children: [
            Container(
              child: Row(children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: getInfoIcon(type),
                  ),
                ),
              ]),
            ),
          ]),
          elevation: 0,
          backgroundColor: const Color(0xFF1D1D1D),
          foregroundColor: Colors.black,
          actions: [
            Container(),
          ],
        ),
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF1D1D1D),
                child: Column(mainAxisSize: MainAxisSize.max ,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Container(height: 500,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black38,
                        border: new Border.all(
                          color: Colors.white12,
                          width: 1.0,
                        ),
                      ),
                      child: ListView.builder(
                          itemCount: specificInfo.length,
                          itemBuilder: (context, position) {
                            return InfoWidget(specificInfo[position]);
                          })),
                  Row(children: [Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 10), child: buttonBack.BackButton())])
                ]))));
  }

  Widget getInfoIcon(String type) {
    switch (type.toLowerCase()) {
      case "prices":
        return Icon(
          Icons.attach_money_rounded,
          size: 30,
          color: const Color(0xFF3A863E)
        );
        break;
      case "service":
        return Column(children: [
          Icon(Icons.account_balance_rounded, color: const Color(0xFFAC8C32), size: 20),
          Icon(
            Icons.directions_bus_outlined,
            size: 20,
            color: const Color(0xFFAC8C32),
          ),
        ]);
        break;
      case "shopping":
        return Icon(Icons.shopping_bag_outlined, color: const Color(0xFF8E364A), size: 40);
        break;
      case "tourism":
        return Column(children: [
          Icon(Icons.beach_access_outlined, color: const Color(0xFF265880), size: 20),
          Icon(
            Icons.attractions,
            size: 20,
            color: const Color(0xFF265880),
          ),
        ]);
        break;
    }
  }

  //database methods

  Future<List<Map<String, dynamic>>> getInfo() async {
    listInfo = [];
    List<Map<String, dynamic>> listMap = (await DBHandler.instance.querySpecificInfos(zone.zoneId.toString()));
    setState(() {
      listMap.forEach((map) => listInfo.add(Info.fromMap(map)));
      debugPrint("did that");
      debugPrint("listinfo size " + listInfo.length.toString());
      getSpecific(type);
      specificInfo = Beautifier(specificInfo);
    });
  }

  void getSpecific(String type) {
    debugPrint("begun");
    List<Info> returned = [];
    String typeLower = type.toLowerCase();
    if (typeLower == "service") {
      for (Info i in listInfo) {
        debugPrint("did this service");
        if (i.infoTyp.toLowerCase() == typeLower || i.infoTyp.toLowerCase() == "transport") {
          returned.add(i);
        }
      }
    } else if (typeLower == "tourism") {
      for (Info i in listInfo) {
        if (i.infoTyp.toLowerCase() == typeLower || i.infoTyp.toLowerCase() == "leisure") {
          debugPrint("did this tourism");
          returned.add(i);
        }
      }
    } else {
      for (Info i in listInfo) {
        if (i.infoTyp.toLowerCase() == typeLower) {
          debugPrint("did this normal");
          returned.add(i);
        }
      }
    }
    specificInfo = returned;
  }
}

class InfoWidget extends StatelessWidget {
  Info thisInfo;
  int position;

  InfoWidget(Info specificInfo) {
    thisInfo = specificInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (thisInfo.infoTyp != "mock") ? EdgeInsets.fromLTRB(10, 2, 10, 1) : EdgeInsets.fromLTRB(10, 15, 10, 5),
        padding: EdgeInsets.fromLTRB(1, 4, 1, 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            thisInfo.infoNam,
            style: TextStyle(fontFamily: "Montserrat", fontSize: (thisInfo.infoTyp != "mock") ? 20 : 24, color: (thisInfo.infoTyp != "mock") ? const Color(0xFFD8DEE9) : Colors.orange.shade400, fontWeight: (thisInfo.infoTyp != "mock") ? FontWeight.w300 : FontWeight.w700),
          ),
          ValueShower(thisInfo)
        ]));
  }
}

class ValueShower extends StatelessWidget {
  Info thisInfo;

  ValueShower(Info thisInfo) {
    this.thisInfo = thisInfo;
  }

  @override
  Widget build(BuildContext context) {
    Widget returned;
    switch (thisInfo.infoTyp) {
      case ("service"):
      case ("shopping"):
        {
          (thisInfo.infoVal.toLowerCase() == "closed")
              ? returned = Text(
                  thisInfo.infoVal,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: Colors.red,
                  ),
                )
              : returned = Text(
                  thisInfo.infoVal,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: Colors.green,
                  ),
                );
        }
        break;
      default:
        {
          returned = Text(
            thisInfo.infoVal,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20,
              color: Colors.green,
            ),
          );
        }
        break;
    }
    return returned;
  }
}

List<Info> Beautifier(List<Info> list) {
  List<Info> beautifiedList = list;
  for (int i = 0; i < (beautifiedList.length - 1); i++) {
    if (beautifiedList[i].infoTyp != beautifiedList[i + 1].infoTyp) {
      beautifiedList.insert(i + 1, new Info(infoZone: beautifiedList[i + 1].infoZone, infoTyp: "mock", infoNam: firstCase(beautifiedList[i + 1].infoTyp), infoVal: ""));
    }
    i++;
  }
  beautifiedList.insert(0, new Info(infoZone: beautifiedList[0].infoZone, infoTyp: "mock", infoNam: firstCase(beautifiedList[0].infoTyp), infoVal: ""));
  return beautifiedList;
}

String firstCase(String original) {
  return original.substring(0, 1).toUpperCase() + original.substring(1).toLowerCase();
}

/**
 *
 */
