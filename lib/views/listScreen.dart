import 'package:flutter/material.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/zoneObject.dart';
import 'package:zone/widgets/rover.dart';

import 'genericPage.dart';
import 'locationScreen.dart';

String currentCountry = "🇵🇹";
String currentCity = "Almada";

List<Zone> listZone;


class ListPage extends GenericPage {
//empty constructor, there isn't much we can do here
  ListPage(){
    listZone = [];

  }

  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends GenericPageState {
  @override
  void initState() {
    if(listZone.isEmpty){
      getZone(currentCity);
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: Row(children: [
            Container(
              child: Row(children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.featured_play_list_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Zone List",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ]),
          elevation: 0,
          backgroundColor: const Color(0xFF1D1D1D),
          foregroundColor: Colors.black,
          actions: [
            Container(
              child: Builder(
                builder: (context) => IconButton(
                  color: Colors.black,

                  icon: Icon(Icons.search_rounded, color: Colors.white),
                  onPressed: () {widget.showToast();},
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF1D1D1D),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(padding:EdgeInsets.fromLTRB(3, 10, 3, 3),decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black38,
                    border: new Border.all(
                      color: Colors.white12,
                      width: 1.0,
                    ),
                  ),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Country:",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 30,
                                color: Colors.orange.shade400,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,

                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black38,
                                  border: new Border.all(
                                    color: Colors.white12,
                                    width: 1.0,
                                  ),
                                ),
                                child: DropdownButton(
                                  iconSize: 0.0,
                                    underline: ColoredBox(
                                      color: Colors.grey.shade900,
                                    ),

                                    dropdownColor: Colors.grey.shade900,
                                    value: 0,
                                    items: [
                                      DropdownMenuItem(
                                        child: Container(

                                          child: Text(
                                            "🇵🇹",
                                            textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 47,
                                                color: const Color(0xFFD8DEE9),
                                              ),
                                          ),
                                        ),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Container(

                                          child: Text(
                                            "🇸🇪",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 47,
                                              color: const Color(0xFFD8DEE9),
                                            ),
                                          ),
                                        ),
                                        value: 1,
                                      ),
                                    ],
                                    onChanged: (value) {
                                    if(value != 1){
                                      setState(() {
                                        value = value;
                                        updateSettings();
                                      });}else widget.showToast();
                                    }))
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "City:",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 30,
                                color: Colors.orange.shade400,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,

                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black38,
                                border: new Border.all(
                                  color: Colors.white12,
                                  width: 1.0,
                                ),
                              ),child:DropdownButton(
                                iconSize: 0.0,
                                underline: ColoredBox(
                                  color: Colors.grey.shade900,
                                ),

                                dropdownColor: Colors.grey.shade900,
                                value: 0,
                                items: [
                                  DropdownMenuItem(
                                    child: Container(
                                    alignment: Alignment.centerRight,
                                      child: Text(
                                          "Almada",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 30,
                                            color: const Color(0xFFD8DEE9),
                                          )
                                      ),
                                    ),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Amadora",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 30,
                                            color: const Color(0xFFD8DEE9),
                                          )
                                      ),
                                    ),
                                    value: 1,
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value!=1){
                                  setState(() {
                                    value = value;
                                    updateSettings();
                                  });}else{
                                    widget.showToast();
                                  }
                                }))
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(onPressed:() => widget.showToast(),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: 90,
                                    height: 70,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black38,
                                      border: new Border.all(
                                        color: Colors.white12,
                                        width: 1.0,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Go",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 30,
                                        color: const Color(0xFFD8DEE9),
                                      ),
                                    ))),
                            TextButton(onPressed:() => widget.showToast(),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: 90,
                                    height: 70,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black38,
                                      border: new Border.all(
                                        color: Colors.white12,
                                        width: 1.0,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Clear",
                                      style: TextStyle(letterSpacing: 0.01,
                                        fontFamily: "Montserrat",
                                        fontSize: 30,
                                        color: const Color(0xFFD8DEE9),
                                      ),
                                    )))
                          ],
                        ),
                      ])),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 250,
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
                          itemCount: listZone.length,
                          itemBuilder: (context, position) {
                            return TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LocPage(listZone[position].zoneId)),
                              );
                            }, child:Container(width: 420, height:40,alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(2, 1, 2, 1),
                              padding:  EdgeInsets.fromLTRB(5, 0, 2, 0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black38,
                                border: new Border.all(
                                  color: Colors.white12,
                                  width: 1.0,
                                ),
                              ),
                            child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[Text(listZone[position].zoneNam,style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 24,
                              color: const Color(0xFFD8DEE9),
                            ),), Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30)])));
                          })),
                  Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Rover(true, true, true, "list")]))
                ]))));
  }

  Future<List<Map<String, dynamic>>> getZone(String currentCity) async{
    listZone = [];
    List<Map<String, dynamic>> listMap = await DBHandler.instance.queryAllRowsZones();
    listMap.forEach((map) => addToListZone(map, currentCity));
    setState(() {

    });
  }

//Method that adds Waypoints to the List, in case they are compliant with the search criteria
  addToListZone(Map<String, dynamic> map, String currentCity) {
    if (Zone.fromMap(map).zoneCty == currentCity) {
      listZone.add(Zone.fromMap(map));
      debugPrint("doing this");
    }
  }

}


