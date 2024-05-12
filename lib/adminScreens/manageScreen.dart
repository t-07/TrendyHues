import 'package:flutter/material.dart';
class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Order History"),
        centerTitle: false,
      ),
      body: new Center(
        child: new CircleAvatar(
          maxRadius: 70.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //new Icon(Icons.border_color),
              new SizedBox(
                height: 10.0,
              ),
              new Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}