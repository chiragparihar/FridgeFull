import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'authenticate.dart';
import 'utils/constants.dart';
class HomeView extends StatefulWidget{
  static const String routeName = "/home";
  @override
  _HomeViewState createState() => _HomeViewState();

}
class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
     // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:Colors.blueAccent,
        title: Text("FridgeFull"),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                Constants.prefs.setBool("loggedIn", false);
                Navigator.pushReplacementNamed(context, Authentication.routeName);
              },
            ),
          )
        ],
      ),
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