//Rover is the Widget at the bottom of the screen which allows us to change between Main Views (Map, List, Home)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zone/views/MainScreen.dart';

class StarShower extends StatelessWidget{

  int nStars;
  bool half = false;
  int roundStars = 0;
  Widget starsW;



  StarShower(double nStars){
    this.nStars = parseStars(nStars);
  }



  Widget homeButton(BuildContext context){

    return IconButton(icon: Icon(Icons.house_rounded,color: Colors.white, size: 30), onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    },             );
  }
  Widget background(BuildContext context){
    return Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_outline_rounded,color:Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
  }
  Widget foreground(BuildContext context){

    return starsW;
  }



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
        ),child:Stack(children:[background(context), foreground(context)]));
  }

  int parseStars(double nStars) {
    int returned = 0;
    switch ((nStars*2).round()){
      case 0:{
        this.nStars = 0;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 1:{
        this.nStars = 0;
        half = true;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_half_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 2:{
        this.nStars = 1;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 3:{
        this.nStars = 1;
        half = true;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_half_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 4:{
        this.nStars = 2;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 5:{
        this.nStars = 2;
        half = true;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_half_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 6:{
        this.nStars = 3;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 7:{
        this.nStars = 3;
        half = true;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_half_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 8:{
        this.nStars = 4;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_outline_rounded,color: Colors.white12, size: 30)],);
      }
      break;
      case 9:{
        this.nStars = 4;
        half = true;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_half_rounded,color: Colors.orangeAccent, size: 30)],);
      }
      break;
      case 10:{
        this.nStars = 5;
        half = false;
        starsW = Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color:Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30),Icon(Icons.star_rounded,color: Colors.orangeAccent, size: 30)],);
      }
      break;
    }

    return returned;
  }



}