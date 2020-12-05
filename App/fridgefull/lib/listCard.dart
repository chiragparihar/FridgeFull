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
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.itemData.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                    widget.itemData.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    widget.itemData.description,
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),
              ],
            ),
            SizedBox(width: 50,),
            Text(
                "\$"+widget.itemData.price.toString(),
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
        children: [
          Divider(
            height: 5.0,
            color: Colors.grey[400],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    color: Colors.blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                    splashColor: Colors.lightBlueAccent,
                    disabledColor: Colors.blue[100],
                    textColor: Colors.white70,
                    onPressed: (){
                      widget.removeItem(widget.itemData);
                    },
                  child: Text(
                      "Remove",
                      style: TextStyle(
                          fontSize: 14
                      )
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  splashColor: Colors.lightBlueAccent,
                  disabledColor: Colors.blue[100],
                  textColor: Colors.white70,
                  onPressed: (){
                    widget.switchList(widget.itemData);
                  },
                  child: Text(
                      "Switch List",
                      style: TextStyle(
                        fontSize: 14
                      )
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




