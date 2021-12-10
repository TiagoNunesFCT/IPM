//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/views/MainScreen.dart';
int nStars = 0;
class StarSelector extends StatefulWidget {


  StarSelector(){
    nStars = 3;
  }

  @override
  StarSelectorState createState() => new StarSelectorState();

  int getStars(){
    return nStars;
  }


}

class StarSelectorState extends State<StarSelector> {
  Widget starsW() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),  visualDensity: VisualDensity.compact,
          icon: Icon((nStars >= 1) ? Icons.star_rounded : Icons.star_border_rounded, color: (nStars >= 1) ? Colors.orangeAccent : Colors.white12, size: 30),
          onPressed: () {
            setState(() {
              nStars = 1;
            });
          },
        ),
        IconButton(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),  visualDensity: VisualDensity.compact,
          icon: Icon((nStars >= 2) ? Icons.star_rounded : Icons.star_border_rounded, color: (nStars >= 2) ? Colors.orangeAccent : Colors.white12, size: 30),
          onPressed: () {
            setState(() {
              nStars = 2;
            });
          },
        ),
        IconButton(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), visualDensity: VisualDensity.compact,
          icon: Icon((nStars >= 3) ? Icons.star_rounded : Icons.star_border_rounded, color: (nStars >= 3) ? Colors.orangeAccent : Colors.white12, size: 30),
          onPressed: () {
            setState(() {
              nStars = 3;
            });
          },
        ),
        IconButton(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), visualDensity: VisualDensity.compact,
          icon: Icon((nStars >= 4) ? Icons.star_rounded : Icons.star_border_rounded, color: (nStars >= 4) ? Colors.orangeAccent : Colors.white12, size: 30),
          onPressed: () {
            setState(() {
              nStars = 4;
            });
          },
        ),
        IconButton(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), visualDensity: VisualDensity.compact,
          icon: Icon((nStars >= 5) ? Icons.star_rounded : Icons.star_border_rounded, color: (nStars >= 5) ? Colors.orangeAccent : Colors.white12, size: 30),
          onPressed: () {
            setState(() {
              nStars = 5;
            });
          },
        )
      ],
    );
  }

  StarSelectorState();


    @override
    Widget build(BuildContext context) {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            color: Colors.black38,
            border: new Border.all(
              color: Colors.white12,
              width: 1.0,
            ),
          ),
          child: starsW());
    }
}
