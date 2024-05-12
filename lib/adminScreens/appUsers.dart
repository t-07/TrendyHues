//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trendy_hues/adminScreens/manageScreen.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/userScreens/address.dart';
import 'package:trendy_hues/userScreens/order.dart';

class AppUsers extends StatefulWidget {
  @override
  _AppUsersState createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  int  index;
  int count;

  @override
  void initState() {
    super.initState();
    getDriversList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("App Users"),
        centerTitle: false,
      ),
      body: _showDrivers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showDrivers() {

    //check if querysnapshot is null
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          index=i;
          count=querySnapshot.documents.length;
          return Column(
            children: <Widget>[
              SizedBox(height: 20,),
              new CircleAvatar(
                maxRadius: 70.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //new Icon(Icons.border_color),
                    new SizedBox(
                      height: 10.0,
                    ),
                    new Text("User"),
                    new Text((i+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              
              Card(elevation: 20,
                  child: ListTile(
                    title: new Text("Email: ${querySnapshot.documents[i]['email']}"),
                    subtitle: new Text("Password: ${querySnapshot.documents[i]['password']}",style: TextStyle(color: Colors.red),),
                  ),

          ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
             

            ],
          );
        },
      );

    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getDriversList() async {
    return await Firestore.instance.collection('users').getDocuments();
  }


/*getListViewItems(String item) {
    showDialog(
        context: context,
        builder:(BuildContext context)
    {
      return AlertDialog(
        title: new Text(item),
        actions:[
          FlatButton(
            child: new Text("ok"),
          )
        ]
      );
    },);
  } */


}