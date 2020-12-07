import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridgefull/groceryItem.dart';
import 'package:fridgefull/groceryList.dart';
List<GroceryItem> groceryList = [
  GroceryItem(title: 'Broccoli', description: 'green veg', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/787/433/6000194787433.jpg',price:10.99),
  GroceryItem(title: 'carrots', description: 'vegetables', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/686/686/6000198686686.jpg',price:6.99),
  GroceryItem(title: 'onions', description: 'vegetables', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/324/982/6000187324982.jpg',price:5.49),
];

List<GroceryItem> fridgeList = [
  GroceryItem(title: 'cheese', description: 'cottage cheese', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/460/932/6000199460932.jpg',price:5.99),
  GroceryItem(title: 'bread', description: 'green veg', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/686/686/6000198686686.jpg',price:6.99),
  GroceryItem(title: 'milk', description: 'skim milk 4%', quantity: 4, image: 'https://i5.walmartimages.ca/images/Large/487/542/6000201487542.jpg',price:4.49),
];

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
    final firestore = FirebaseFirestore.instance;
    authobj retobj = authobj(true, "");
    try{
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: email.trim(), password: psk.trim());
      groceryList.forEach((element) {

        firestore.collection('users').doc(_auth.currentUser.uid).collection('grocerylist').add(element.toJson());

      });

      fridgeList.forEach((element) {

        firestore.collection('users').doc(_auth.currentUser.uid).collection('fridgelist').add(element.toJson());

      });

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





