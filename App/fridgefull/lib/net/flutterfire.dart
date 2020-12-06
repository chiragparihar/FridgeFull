import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //sign in with email and psk
  //register with email
  //sign out

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email,String psk) async{
    authobj retobj = authobj(true, "");
    try{
      UserCredential userCredential =  await _auth.signInWithEmailAndPassword(email: email.trim(), password: psk.trim());
    }
    catch(e){
      print(e.code);
      retobj.message = e.code;
      retobj.value = false;
    }
    return retobj;

  }
  String getUserId(){
    return _auth.currentUser.uid;
  }
  bool isSignedIn(){
    if(_auth.currentUser != null) {
        return true;
    }
    else{
      return false;
    }
  }
  Future Register(String email,String psk) async{
    authobj retobj = authobj(true, "");
    try{
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: email.trim(), password: psk.trim());
    }
    catch(e){
      print(e.code);
      retobj.message = e.code;
      retobj.value = false;
    }
    return retobj;

  }
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

class authobj{
  bool value;
  String message;
  authobj(this.value,this.message);

}





