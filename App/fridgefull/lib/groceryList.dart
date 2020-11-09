import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'groceryItem.dart';
import 'listCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

GroceryItem item1 = GroceryItem(title: 'onions', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD');

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


class GroceryList extends StatefulWidget {


  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
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
      String desc = (((data['products'][0])["description"]).length > 20) ? ((data['products'][0])["description"])[20]:((data['products'][0])["description"]);
      double pc = double.parse(data['products'][0]["stores"][0]["store_price"]);
      item = GroceryItem(image: (data['products'][0])['images'][0],title:(data['products'][0]["product_name"].split(","))[0],quantity:1,description:desc,price:pc);
      print(data);
      print((data['products'][0]["product_name"].split(","))[0]);
      print((data['products'][0])['images'][0]);
      print((data['products'][0])['images'][0]);
      setState(() {
        currentIndex == 0 ? groceryList.add(item): fridgeList.add(item);
      });


    }

    if(res.statusCode == 404) {
      print("product not found");
    }
  }
  _addItem(GroceryItem item){
    if(currentIndex == 0) {
      setState(() {
        groceryList.add(item);
      });
    }
    else if(currentIndex == 1){
      setState(() {
        fridgeList.add(item);
      });
    }
  }

  _removeItem(GroceryItem item){
    if(currentIndex == 0) {
      setState(() {
        groceryList.remove(item);
      });
    }
    else if (currentIndex == 1){
      setState(() {
        fridgeList.remove(item);
      });
    }
  }

  _switchList(GroceryItem item){
    if(currentIndex == 0){
      setState(() {
        groceryList.remove(item);
        fridgeList.add(item);
      });
    }
    else if(currentIndex == 1){
      setState(() {
        fridgeList.remove(item);
        groceryList.add(item);
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final tabs = [
      ListView(
          children: groceryList.map((item) => ListCardTemplate(
            itemData: item,
            addItem: _addItem,
            removeItem: _removeItem,
            switchList: _switchList,
          )).toList()
      ),
      ListView(
          children: fridgeList.map((item) => ListCardTemplate(
            itemData: item,
            addItem: _addItem,
            removeItem: _removeItem,
            switchList: _switchList,
          )).toList()
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      /*
      appBar: AppBar(
        title: Text('myFridge'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),*/
      body: tabs[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          scanBarcodeNormal();
          setState(() {
            //currentIndex == 0 ? groceryList.add(item1): fridgeList.add(item1);

          }
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Grocery List',
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