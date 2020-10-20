


import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email,String psk) async{
  print("email is $email");
  print("password is $psk");
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: psk.trim());
    return true;
  } catch(e){
    print(e);
    return false;
  }
}

Future<bool> register(String email,String psk) async{
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: psk.trim());
    return true;
  } on FirebaseAuthException catch(e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak');
    } else if (e.code == 'email-already-taken') {
      print('The account already exists');
    }
    return false;
  }
  catch(e){
    print("otehr error");
    print(e.toString());
    return false;
  }

  }


