import 'package:flutter/material.dart';
import 'package:zone/widgets/rover.dart';

import 'genericPage.dart';

String currentCountry = "🇵🇹";
String currentCity = "Almada";


//TODO ADD NUMBER OF CITIES AND METHOD TO CALCULATE NUMBER OF CITIES WHEN FETCHING ALL ZONES
//TODO ADD NUMBER OF COUNTRIES AND METHOD TO CALCULATE NUMBER OF COUNTRIES WHEN FETCHING ALL ZONES
//TODO ADD DYNAMIC LIST BUILDING IN THE DROPDOWN MENUS

class ListPage extends GenericPage {
//empty constructor, there isn't much we can do here
  ListPage();

  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends GenericPageState {
  @override
  void initState() {
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
                builder: (context) => PopupMenuButton(
                  color: Colors.black,
                  itemBuilder: (context) {
                    var list = <PopupMenuEntry<Object>>[];
                    list.add(
                      PopupMenuItem(
                        child: Text(
                          "Zoom to Location",
                          style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        value: 1,
                      ),
                    );
                    list.add(
                      PopupMenuItem(
                        child: Text(
                          "Zoom to All",
                          style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        value: 3,
                      ),
                    );
                    list.add(
                      PopupMenuItem(
                        child: Text(
                          "Reset Geolocation",
                          style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        value: 0,
                      ),
                    );
                    list.add(
                      PopupMenuItem(
                        child: Text(
                          (autoZoom == 1) ? "Disable Auto-Zoom" : "Enable Auto-Zoom",
                          style: TextStyle(fontFamily: "Montserrat", color: const Color(0xFFD8DEE9), fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        value: 2,
                      ),
                    );
                    return list;
                  },
                  icon: Icon(Icons.search_rounded, color: Colors.white),
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        {
                          debugPrint("0");
                        }
                        break;
                      case 1:
                        {
                          debugPrint("1");
                        }
                        break;
                      case 2:
                        {
                          setState(() {
                            (autoZoom == 1) ? autoZoom = 0 : autoZoom = 1;
                            updateSettings();
                          });
                        }
                        break;
                      case 3:
                        {
                          debugPrint("3");
                        }
                        break;
                    }
                  },
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
                                color: Colors.white,
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
                                                color: Colors.white,
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
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        value: 1,
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        value = value;
                                        updateSettings();
                                      });
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
                                color: Colors.white,
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
                                            color: Colors.white,
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
                                            color: Colors.white,
                                          )
                                      ),
                                    ),
                                    value: 1,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    value = value;
                                    updateSettings();
                                  });
                                }))
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: 80,
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
                                        color: Colors.white,
                                      ),
                                    ))),
                            TextButton(
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: 80,
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
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 30,
                                        color: Colors.white,
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
                          itemCount: 35,
                          itemBuilder: (context, position) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(2, 1, 2, 1),
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black38,
                                border: new Border.all(
                                  color: Colors.white12,
                                  width: 1.0,
                                ),
                              ),
                            child:Text(position.toString(),style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 30,
                              color: Colors.white,
                            ),));
                          })),
                  Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Rover(true, true, false)]))
                ]))));
  }
}
