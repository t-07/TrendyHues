import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:trendy_hues/userScreens/address.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'package:trendy_hues/userScreens/order.dart';
class TrendyHistory extends StatefulWidget {
  @override
  _TrendyHistoryState createState() => _TrendyHistoryState();
}



class _TrendyHistoryState extends State<TrendyHistory> {
  var string = orderDetail.details(orderid).toString();
  var string2 = orderDetail.details1(title).toString();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Order History"),
        centerTitle: false,
      ),
      body: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: ListTile(focusColor: Colors.blue,
          selectedTileColor: Colors.red,
          leading: const Icon(Icons.history),
          title: Text("Order ID : $string"),
          subtitle: new Row(
            children: [
              Text("Product : $string2"),
              SizedBox(width: 20,),
              Text(formattedDate,style: TextStyle(color: Colors.red),)
            ],
          )

        ),
        actions: <Widget>[
          IconSlideAction(
              caption: 'Cancel',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => alertdialog(string),
          ),
        ],
      ),
    );
  }

  Future <void> alertdialog(String orderID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("CANCEL ORDER ???",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  IconButton(
                    icon: new Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    ),),
                  Text("ORDER.NO : " + orderID,
                    style: TextStyle(
                      color: Colors.red,
                    ),),
                ],
              )
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                   Navigator.of(context).pop();}
            ),
                 TextButton(
                        child: Text("Cancel order"),
                         onPressed: () {
                         Firestore.instance.collection("usersData").document(orderID).delete();
                         Fluttertoast.showToast(msg: 'Your Order has been cancelled.Help us serve you better..Thanks!',backgroundColor: Colors.red);
                         Navigator.pop(context);
                         Navigator.pushReplacement(context, new MaterialPageRoute(builder:(context)=> new TrendyAddress(),),);
                         setState(() {
                            orderID=null;
                            string2=null;
                         });
                         //string= null;
                         //string2= null;
                         //Navigator.pop(context);
                        // Navigator.pushNamed(context, '/mainPage');


                         print("deleted :"+ orderID);
                         //showmessage();
                        }
                      )
          ],
        );
      },);
  }
}