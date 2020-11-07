import 'groceryItem.dart';
import 'package:flutter/material.dart';


class ListCardTemplate extends StatefulWidget {

  final GroceryItem itemData;

  void Function(GroceryItem item ) addItem;

  void Function(GroceryItem item) removeItem;

  void Function(GroceryItem item) switchList;

 ListCardTemplate({this.itemData, this.addItem, this.removeItem, this.switchList});

  @override
  _ListCardTemplateState createState() => _ListCardTemplateState();
}


class _ListCardTemplateState extends State<ListCardTemplate> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Image(
          image: NetworkImage('https://image.shutterstock.com/z/stock-photo-broccoli-vegetable-isolated-on-white-background-175387835.jpg'),
        ),
        title: Text(widget.itemData.title),
        subtitle: Text(widget.itemData.description),
        children: [
          Divider(
            height: 5.0,
            color: Colors.grey[800],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton.icon(
                    color: Colors.blue,
                    disabledColor: Colors.blue[100],
                    textColor: Colors.white70,
                    onPressed: (){
                      widget.removeItem(widget.itemData);
                    },
                    icon: Icon(Icons.cancel_outlined),
                    label: Text('Remove'),
                ),
                RaisedButton.icon(
                  color: Colors.blue,
                  disabledColor: Colors.blue[100],
                  textColor: Colors.white70,
                  onPressed: (){
                    widget.switchList(widget.itemData);
                  },
                  icon: Icon(Icons.cancel_outlined),
                  label: Text('Switch List'),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




