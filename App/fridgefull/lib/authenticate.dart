import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import  'package:google_sign_in/google_sign_in.dart';

import 'home_view.dart';
import 'net/flutterfire.dart';


class Authentication extends StatefulWidget{
  @override
  _AuthenticationState createState() => _AuthenticationState();

}
class _AuthenticationState extends State<Authentication>{
  TextEditingController _email = TextEditingController();
  TextEditingController _psk = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:Colors.blueAccent,

        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                hintText: "something@email.com",
                hintStyle: TextStyle(color:Colors.white),
                labelText: "Email",
                labelStyle: TextStyle(color:Colors.white),
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: _psk,
              decoration: InputDecoration(
                hintText: "password",
                hintStyle: TextStyle(color:Colors.white),
                labelText: "Password",
                labelStyle: TextStyle(color:Colors.white),
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width /1.4,
              height:45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color:Colors.white,
              ),
              child:MaterialButton(
                onPressed: () async{
                  bool shouldNavigate = await register(_email.text,_psk.text);
                  print(shouldNavigate);
                  if(shouldNavigate){
                    Navigator.pushNamed(context,HomeView.routeName);
                  }
                },
                child:Text("Register"),
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width /1.4,
              height:45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color:Colors.white,
              ),
              child:MaterialButton(
                onPressed: () async{
                  bool shouldNavigate = await signIn(_email.text,_psk.text);
                  if(shouldNavigate){
                    Navigator.push(context,MaterialPageRoute(builder:(context) => HomeView()));
                  }
                },
                child:Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}