import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zone/widgets/rover.dart';
import 'genericPage.dart';
import 'package:latlong2/latlong.dart';

//The Google Maps Tile Layer
TileLayerOptions mapService = TileLayerOptions(
    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    subdomains: ['a', 'b', 'c']);

//The Map Options
MapOptions mapOpts;



//The Map
FlutterMap _map;


class MapPage extends GenericPage {
//empty constructor, there isn't much we can do here
  MapPage();



@override
_MapPageState createState() => new _MapPageState();
}

class _MapPageState extends GenericPageState {




  @override
  void initState() {
    super.initState();
    initMap();
  }

  initMap(){

  _map = FlutterMap(options: MapOptions(
    center: LatLng(38.66, -9.17),
    zoom: 13.0,
  ),
    layers: [
      mapService,
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(38.66, -9.17),
            builder: (ctx) =>
                Container(
                  child: FlutterLogo(),
                ),
          ),
        ],
      ),
    ],
  );

  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: Row(children: [
          Container(
            child: Row(children:[Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.map_rounded, size: 30,color: Colors.white,),
              ),
            ), Text("Zone Map", style: TextStyle(fontSize: 20,
              fontFamily: "Montserrat",
              color: Colors.white,
            ),)]),
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
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: const Color(0xFFD8DEE9),
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      value: 1,
                    ),
                  );
                  list.add(
                    PopupMenuItem(
                      child: Text(
                        "Zoom to All",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: const Color(0xFFD8DEE9),
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      value: 3,
                    ),
                  );
                  list.add(
                    PopupMenuItem(
                      child: Text(
                        "Reset Geolocation",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: const Color(0xFFD8DEE9),
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      value: 0,
                    ),
                  );
                  list.add(
                    PopupMenuItem(
                      child: Text(
                        (autoZoom == 1)
                            ? "Disable Auto-Zoom"
                            : "Enable Auto-Zoom",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: const Color(0xFFD8DEE9),
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
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

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _map,
          Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10),child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Rover(true, false, true)]))
        ],
      ),

    );
  }
}

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}