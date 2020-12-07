import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'groceryItem.dart';
import 'listCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'net/flutterfire.dart';


class GroceryList extends StatefulWidget {

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final AuthService _auth = AuthService();
  String id ;
  List<GroceryItem> groceryList ;
  List<GroceryItem> fridgeList ;
  String _scanBarcode = 'Unknown';
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    fetchData();
  }
  @override
  void initState(){
    super.initState();
    getGroceyList();
    getFridgeList();
  }
  Future getGroceyList() async{
    id = _auth.getUserId();
    await FirebaseFirestore.instance
        .collection('users').doc(id).collection("grocerylist")
        .get()
        .then((QuerySnapshot querySnapshot) => {
      groceryList =[],
      querySnapshot.docs.forEach((doc) {
        Map<String,dynamic> useritem = doc.data();
        var userdata = GroceryItem.fromJson(useritem);
        groceryList.add(userdata);
      }),
      setState(() {}),
    });

  }
  Future getFridgeList() async{
    final AuthService _auth = AuthService();
    print(_auth.getUserId());
    await FirebaseFirestore.instance
        .collection('users').doc(id).collection("fridgelist")
        .get()
        .then((QuerySnapshot querySnapshot) => {
          fridgeList =[],
      querySnapshot.docs.forEach((doc) {
        Map<String,dynamic> useritem = doc.data();
        var userdata = GroceryItem.fromJson(useritem);
        fridgeList.add(userdata);
      }),
    setState(() {}),
    });

  }
  Future addtoFridge(item) async{
    await FirebaseFirestore.instance
        .collection('users').doc(id).collection("fridgelist").add(item.toJson());
    fridgeList.add(item);
  }
  Future addtoGrocery(item) async{
    await FirebaseFirestore.instance
        .collection('users').doc(id).collection("grocerylist").add(item.toJson());
    groceryList.add(item);
  }
  void removeGrocery(item) async{
    Query q = await FirebaseFirestore.instance
        .collection('users').doc(id).collection("grocerylist").where('title' , isEqualTo: item.title.toString());
    q.get().then((QuerySnapshot querySnapshot)=>{
      querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
      })
    });
    groceryList.remove(item);

  }
  void removeFridge(item) async{
    Query q = await FirebaseFirestore.instance
        .collection('users').doc(id).collection("fridgelist").where('title', isEqualTo: item.title.toString());
    q.get().then((QuerySnapshot querySnapshot)=>{
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      })
    });
    fridgeList.remove(item);


  }
  fetchData() async{

    GroceryItem item;
    String url = "https://api.barcodelookup.com/v2/products?barcode=$_scanBarcode&key=3uhky000hei7jd23mhvr2pxunqqxie";
    var res = await http.get(url);
    print(res.statusCode);
    print(url);
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      print(data);
      String desc = (((data['products'][0])["description"]).length > 35) ? (data['products'][0]["description"]).substring(0,35).split(",")[0]:((data['products'][0])["description"].split(",")[0]);
      print((data['products'][0])["description"].split(",")[0]);
      double pc = double.parse(data['products'][0]["stores"][0]["store_price"]);
      item = GroceryItem(image: (data['products'][0])['images'][0],title:(data['products'][0]["product_name"].split(","))[0],quantity:1,description:desc,price:pc);


      setState(() {
        currentIndex == 0 ? addtoGrocery(item):addtoFridge(item);
      });


    }

    if(res.statusCode == 404) {
      print("product not found");
    }
  }
  _addItem(GroceryItem item){
    if(currentIndex == 0) {
      setState(() {
        addtoGrocery(item);
      });
    }
    else if(currentIndex == 1){
      setState(() {
        addtoFridge(item);
      });
    }
  }

  _removeItem(GroceryItem item){
    if(currentIndex == 0) {
      setState(() {
        removeGrocery(item);
      });
    }
    else if (currentIndex == 1){
      setState(() {
        removeFridge(item);
      });
    }
  }

  _switchList(GroceryItem item){
    if(currentIndex == 0){
      setState(() {
        removeGrocery(item);
        addtoFridge(item);
      });
    }
    else if(currentIndex == 1){
      setState(() {
        removeFridge(item);
        addtoGrocery(item);
      });
    }
  }

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {


    final tabs = groceryList != null ? [
      ListView(
          children: groceryList.map((item) => ListCardTemplate(
            itemData: item,
            addItem: _addItem,
            removeItem: _removeItem,
            switchList: _switchList,
          )).toList(),
      ),
      ListView(
          children: fridgeList.map((item) => ListCardTemplate(
            itemData: item,
            addItem: _addItem,
            removeItem: _removeItem,
            switchList: _switchList,
          )).toList()
      ),
    ]: [Center(
        child: CircularProgressIndicator()
    )];

    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      /*
      appBar: AppBar(
        title: Text('myFridge'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),*/
      body: tabs[currentIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(
            Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          scanBarcodeNormal();
          setState(() {
            //currentIndex == 0 ? groceryList.add(item1): fridgeList.add(item1);

          }
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,

        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue[700],
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.shopping_cart,
            ),
            label: "Grocery List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Fridge List',
          ),
        ],
      ),
    );
  }
}