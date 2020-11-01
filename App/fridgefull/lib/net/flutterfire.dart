
import 'package:firebase_auth/firebase_auth.dart';

class auth{
  auth(this.ans,this.msg);
  bool ans;
  String msg="";
  void answer(bool a){
    ans =a;
  }
  void message(String m){
    msg = m;
  }
  bool get answ{
    return ans;
  }
  String get mess{
    return msg;
  }
}

Future<auth> signIn(String email,String psk) async{
  print("email is $email");
  print("password is $psk");
  auth a1 = auth(false,"");
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: psk.trim());
    a1.answer(true);
  } catch(e){
    print(e.code);
    a1.answer(false);
    a1.message(e.code);
  }
  return a1;
}

Future<auth> register(String email,String psk) async{
  auth a2 = auth(false,"");
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: psk.trim());
    a2.answer(true);
  } on FirebaseAuthException catch(e) {
    a2.message(e.code);
    if (e.code == 'weak-password') {
      print('The password provided is too weak');
    } else if (e.code == 'email-already-taken') {
      print('The account already exists');
    }
    a2.answer(false);
  }
  catch(e){
    print("other error");
    print(e.toString());
    a2.answer(false);
    a2.message(e.code);
  }
  return a2;
  }


