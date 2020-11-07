import 'dart:convert';

import 'package:flutter/material.dart';
import 'groceryItem.dart';
import 'listCard.dart';
import 'package:http/http.dart' as http;


GroceryItem item1 = GroceryItem(title: 'onions', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD');

List<GroceryItem> groceryList = [
  GroceryItem(title: 'Broccoli', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
  GroceryItem(title: 'carrots', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
  GroceryItem(title: 'onions', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
];

List<GroceryItem> fridgeList = [
  GroceryItem(title: 'cheese', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
  GroceryItem(title: 'bread', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
  GroceryItem(title: 'milk', description: 'green veg', quantity: 4, image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FBroccoli&psig=AOvVaw08NJjY9g5TCxsyXkzJtGFP&ust=1604621080540000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMiKsL6N6uwCFQAAAAAdAAAAABAD'),
];


class GroceryList extends StatefulWidget {


  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  //final String key = "s0d7tujx0amxrm4mkt1slxr9q4tlll";
  //final String barcode = "3614272049529";
  @override
  void initState(){
    super.initState();
    fetchData();
  }
  fetchData() async{
    String url = "https://api.barcodelookup.com/v2/products?barcode=9780140157376&key=3uhky000hei7jd23mhvr2pxunqqxie";
    var res = await http.get(url);
    print(res.statusCode);
    var data = jsonDecode(res.body);
    setState(() {

    });
    if(res.statusCode == 200) {
      print("yes");
    }
    print(data);
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
          setState(() {
            fetchData();
            currentIndex == 0 ? groceryList.add(item1): fridgeList.add(item1);

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