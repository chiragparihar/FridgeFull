import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class HomeView extends StatefulWidget{
  static const String routeName='/home';
  @override
  _HomeViewState createState() => _HomeViewState();

}
class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          color:Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:Center(
          child:Text("you signed in"),
      ),
      ),
    );
  }
}