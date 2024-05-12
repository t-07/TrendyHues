import 'package:flutter/material.dart';
class TrendyNotifications extends StatefulWidget {
  @override
  _TrendyNotificationsState createState() => _TrendyNotificationsState();
}

class _TrendyNotificationsState extends State<TrendyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Notifications"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Notifications",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
