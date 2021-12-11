import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zone/widgets/rover.dart';
import 'genericPage.dart';
import 'package:latlong2/latlong.dart';

import 'locationScreen.dart';

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
            point: LatLng(38.657, -9.15),
            builder: (ctx) =>
                Container(
                  child: IconButton(icon: Icon(Icons.my_location_rounded, color:Colors.red),onPressed: () {                        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocPage.currentLoc()),
                  );},),
                ),
          ),
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(38.663, -9.215),
            builder: (ctx) =>
                Container(
                  child: IconButton(icon: Icon(Icons.my_location_rounded, color:Colors.red),onPressed: () {                        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocPage(1)),
                  );},),
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
              builder: (context) => IconButton(
                color: Colors.black,

                icon: Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {widget.showToast();},
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