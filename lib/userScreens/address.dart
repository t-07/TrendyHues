import 'package:flutter/material.dart';
class TrendyAddress extends StatefulWidget {
  @override
  _TrendyAddressState createState() => _TrendyAddressState();
}

class _TrendyAddressState extends State<TrendyAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Order History"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}