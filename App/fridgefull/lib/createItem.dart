import 'package:flutter/material.dart';

class createItem extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Name",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name"
            ),
          ),
          Text(
            "Description",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description"
            ),
          ),
          Text(
            "Price",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Price"
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
              onPressed: null,
            child: Text(
                "Add",
                style: TextStyle(
                    fontSize: 14
                )
            ),
          ),
        ],
      ),
    );
  }
}
