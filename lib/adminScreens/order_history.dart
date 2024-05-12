//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trendy_hues/adminScreens/manageScreen.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/userScreens/address.dart';
import 'package:trendy_hues/userScreens/order.dart';

class Order_history extends StatefulWidget {
  @override
  _Order_historyState createState() => _Order_historyState();
}

class _Order_historyState extends State<Order_history> {
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
        title: new Text("Orders"),
        centerTitle: false,
      ),
      body:_showDrivers(),

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

              SizedBox(height: 10,),
              new CircleAvatar(
                maxRadius: 70.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //new Icon(Icons.border_color),
                    new SizedBox(
                      height: 10.0,
                    ),
                    new Text("Order"),
                    new Text((i+1).toString()),
                    // new Text(querySnapshot.documents.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Text("Name : ${querySnapshot.documents[i]['acctFullName']}",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.red),),
              Text("Address : ${querySnapshot.documents[i]['address']} , ${querySnapshot.documents[i]['city']}"),
             // Text("City : ${querySnapshot.documents[i]['city']}"),
              Text("State :${querySnapshot.documents[i]['state']} ${querySnapshot.documents[i]['pin']}"),
              Text("Mobile ${querySnapshot.documents[i]['phoneNumber']}"),
              Text("Product Details",
              style: TextStyle(fontWeight: FontWeight.w900,color: Colors.teal),),
             // Text("Color :${querySnapshot.documents[i]['productColor']}"),
              Text("Amount : INR ${querySnapshot.documents[i]['productPrice']} , ${querySnapshot.documents[i]['productColor']}"),
             // Text("Quantity :${querySnapshot.documents[i]['productQty']}"),
              Text("Size :${querySnapshot.documents[i]['productSize']} , ${querySnapshot.documents[i]['productQty']} Packets"),
              Text("Product :${querySnapshot.documents[i]['productTitle']}"),
              Text("Email: ${querySnapshot.documents[i]['userEmail']}"),
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed:() {alert(index);}
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),


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
    return await Firestore.instance.collection('usersData').getDocuments();
  }

  Future <void> alert(index) {
     setState(() {
       Firestore.instance.collection('usersData').doc('56jDukVJiPXiwYMVBJdW').delete();
       Navigator.pushReplacement(context, new MaterialPageRoute(builder:(context)=> new Order_history(),),);
     });
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