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
  String _err= "";
  void changeErr(String err){
    setState(() {
      _err = err;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:Colors.blueAccent,

        ),
        child:SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height:200,
                child: Center(
                  child: Text(
                    _err,
                    style:TextStyle(fontSize: 25,color: Colors.white),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "something@email.com",
                    hintStyle: TextStyle(color:Colors.white),
                    labelText: "Email",
                    labelStyle: TextStyle(color:Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _psk,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "password",
                    hintStyle: TextStyle(color:Colors.white),
                    labelText: "Password",
                    labelStyle: TextStyle(color:Colors.white),
                  ),
                ),
              ),
              Container(
                padding:const EdgeInsets.all(16.0),
                child: Container(
                  width:MediaQuery.of(context).size.width /1.4,
                  height:45,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15.0),
                    color:Colors.white,
                  ),
                  child:MaterialButton(
                    onPressed: () async{
                      auth shouldNavigate = await register(_email.text,_psk.text);
                      print(shouldNavigate);
                      if(shouldNavigate.answ){
                        Navigator.pushNamed(context,HomeView.routeName);
                      }
                      else{
                        _psk.clear();
                        _email.clear();

                        changeErr(shouldNavigate.mess);
                      }
                    },
                    child:Text("Register"),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width:MediaQuery.of(context).size.width /1.4,
                  height:45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color:Colors.white,
                  ),
                  child:MaterialButton(
                    onPressed: () async{
                      auth shouldNavigate = await signIn(_email.text,_psk.text);
                      if(shouldNavigate.answ){
                        Navigator.push(context,MaterialPageRoute(builder:(context) => HomeView()));
                      }
                      else{
                        changeErr(shouldNavigate.mess);
                        _psk.clear();
                        _email.clear();
                      }
                    },
                    child:Text("Login"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}