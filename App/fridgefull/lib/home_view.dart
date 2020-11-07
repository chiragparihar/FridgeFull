import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'authenticate.dart';
import 'utils/constants.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fridgefull/groceryList.dart';
class HomeView extends StatefulWidget{
  static const String routeName = "/home";
  @override
  _HomeViewState createState() => _HomeViewState();

}
class _HomeViewState extends State<HomeView>{
  String _scanBarcode = 'Unknown';
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
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
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
     // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:Colors.blueAccent,
        title: Text("FridgeFull"),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                Constants.prefs.setBool("loggedIn", false);
                Navigator.pushReplacementNamed(context, Authentication.routeName);
              },
            ),
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            RaisedButton(
              onPressed: () => scanBarcodeNormal(),
              child: Text("Start barcode scan")),

            Text('Scan result : $_scanBarcode\n',
            style: TextStyle(fontSize: 20))
            ])));

  }
}