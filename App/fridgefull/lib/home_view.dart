import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'authenticate.dart';
import 'utils/constants.dart';

import 'dart:async';

import 'package:fridgefull/groceryList.dart';
class HomeView extends StatefulWidget{
  static const String routeName = "/home";
  @override
  _HomeViewState createState() => _HomeViewState();

}
class _HomeViewState extends State<HomeView>{

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context){
    return Scaffold(
     // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:Colors.blue[700],
        title: Center(
          child: Text(
              "MyFridge",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                Constants.prefs.setBool("loggedIn", false);
                Navigator.pushReplacementNamed(context, Authentication.routeName);
              },
            ),
          )
        ],
      ),
      body: GroceryList());
      /*Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            RaisedButton(
              onPressed: () => scanBarcodeNormal(),
              child: Text("Start barcode scan")),

            Text('Scan result : $_scanBarcode\n',
            style: TextStyle(fontSize: 20))
            ])));
*/
  }
}