//import 'dart:html';
//import 'dart:html';
//import 'dart:html';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trendy_hues/Config/config.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';


String orderid;
String title;
var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

class TrendyOrder extends StatefulWidget {
  @override
  _TrendyOrderState createState() => _TrendyOrderState();
}

class _TrendyOrderState extends State<TrendyOrder> {


  List<DropdownMenuItem<String>> dropDownColors;
  String selectedColor;
  List<String> colorList = new List();

  List<DropdownMenuItem<String>> dropDownSizes;
  String selectedSize;
  List<String> sizeList = new List();
  Map<int, File> imagesMap = new Map();

  TextEditingController NameController = new TextEditingController();
  TextEditingController ContactController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();
  TextEditingController PincodeController = new TextEditingController();
  TextEditingController StateController = new TextEditingController();
  TextEditingController CityController = new TextEditingController();
  TextEditingController productTitleController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();
  TextEditingController productqtyController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorList = new List.from(localColors);
    sizeList = new List.from(localSizes);
    dropDownColors = buildAndGetDropDownItems(colorList);
    dropDownSizes = buildAndGetDropDownItems(sizeList);
    selectedColor = dropDownColors[0].value;
    selectedSize = dropDownSizes[0].value;
  }


  @override
  Widget build(BuildContext context) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.yellow.shade50,
      appBar: new AppBar(
        backgroundColor: Colors.yellow,
        title: new Text("Make an Order",
        style: TextStyle(
          color: Colors.black,
        ),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: <Widget>[
          /*Padding(
            padding: const EdgeInsets.all(10.0),
            child: new RaisedButton.icon(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(15.0))),
                onPressed: () => pickImage(),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: new Text(
                  "Add Images",
                  style: new TextStyle(color: Colors.white),
                )),
          )*/
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              child: TextField(
                decoration: InputDecoration(filled: true,
                    fillColor: Colors.white,
                    labelText: firebaseUser.email),
                readOnly: true,
                enabled: false,
              ),
            ),
            /* MultiImagePickerList(
                imageList: imageList,
                removeNewImage: (index) {
                  removeImage(index);
                }),*/
            new SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              child: TextField(
                controller: NameController,
                decoration: InputDecoration(filled: true,
                    fillColor: Colors.white,
                    labelText: "Enter your name"),
              ),
            ),
            new SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: TextField(
                  maxLength: 10,
                  maxLengthEnforced: true,
                  controller: ContactController,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter your contact"),)),
            new SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: TextField(
                  controller: AddressController,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter your address"),)),
            new SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: TextField(
                  controller: CityController,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter your city"),)),
            new SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: TextField(
                  controller: StateController,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter your state"),)),
            new SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: TextField(
                  controller: PincodeController,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter your postal code"),)),
            new SizedBox(
              height: 10.0,
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                productDropDown(
                    textTitle: "Color",
                    selectedItem: selectedColor,
                    dropDownItems: dropDownColors,
                    changedDropDownItems: changedDropDownColor),
                productDropDown(
                    textTitle: "Size",
                    selectedItem: selectedSize,
                    dropDownItems: dropDownSizes,
                    changedDropDownItems: changedDropDownSize),
              ],
            ),*/
            new SizedBox(
              height: 20.0,
            ),
            appButton(
                btnTxt: "Order",
                onBtnclicked: OrderProducts,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
          ],
        ),
      ),
    );
  }


  AppMethods appMethod = new FirebaseMethods();

  void OrderProducts() async {
    User firebaseUser = FirebaseAuth.instance.currentUser;

    if (NameController.text == "") {
      showSnackBar("Name cannot be empty", scaffoldKey);
      return;
    }

    if (ContactController.text == "") {
      showSnackBar("Contact number cannot be empty", scaffoldKey);
      return;
    }

    if (ContactController.text.length <10 && ContactController.text.length !=7) {
      showSnackBar("Enter a valid contact number", scaffoldKey);
      return;
    }


    if (AddressController.text == "") {
      showSnackBar("Address cannot be empty", scaffoldKey);
      return;
    }

    if (PincodeController.text == "") {
      showSnackBar("Pincode cannot be empty", scaffoldKey);
      return;
    }

    if (PincodeController.text.length<4 ||  PincodeController.text.length>6) {
      showSnackBar("Enter a valid pincode", scaffoldKey);
      return;
    }
    if (CityController.text == "") {
      showSnackBar("City cannot be empty", scaffoldKey);
      return;
    }
    if (StateController.text == "") {
      showSnackBar("State cannot be empty", scaffoldKey);
      return;
    }

    //show the progress dialog
    displayProgressDialog(context);


    Map<String, dynamic> newOrder = {
      userEmail: firebaseUser.email,
      acctFullName: NameController.text,
      phoneNumber: ContactController.text,
      address: AddressController.text,
      city: CityController.text,
      state: StateController.text,
      pin: PincodeController.text,
      productTitle: data,
      productPrice: data1,
      productColor: itemdetails.giveColor(),
      productSize: itemdetails.giveSize(),
      productQty: itemdetails.giveQty(),
      date: formattedDate,

    };

    //adding the information to firebase
    String orderID = await appMethod.addOrder(newOrder: newOrder);
    showSnackBar("Order made successfully", scaffoldKey);
    alertdialog(orderID);
    orderid=orderID;
    title = data;
    details(orderid);
    details1(data);

    //upload images to firebase storage
    //List<String> imagesUrl = await appMethod.uploadProductImages(docID:productID , imageList: imageList);


    // check if error occured while adding images to firebase storage
    // if(imagesUrl.contains(error)){
    //  closeProgressDialog(context);
    // showSnackBar("image upload error , contact developer", scaffoldKey);
    // }

    // bool result = await appMethod.updateProductImages(docID:productID , data: imagesUrl);
    // if(result !=null && result == true){
    //   closeProgressDialog(context);
    //   showSnackBar("product added successfully", scaffoldKey);
    // }else{
    // closeProgressDialog(context);
    // showSnackBar("an error occured,contact developer", scaffoldKey);
  }

  Future <void> alertdialog(String orderID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success! Order Made Successfully..",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  IconButton(
                    icon: new Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 30,
                    ),),
                  Text("ORDER.NO : " + orderID,
                    style: TextStyle(
                      color: Colors.red,
                    ),),
                  Text(firebaseUser.email,style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),),
                  Text("NAME : "+ NameController.text),
                  Text("CONTACT :" + ContactController.text),
                  Text("ADDRESS : " +AddressController.text),
                  Text("CITY : " + CityController.text),
                  Text("STATE : " + StateController.text),
                  Text("PIN : " + PincodeController.text),
                  Text("ORDER : " + data),
                  Text("PRICE : INR  " + data1),
                  Text("Order Date : "+ formattedDate),


                ],
              )
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                closeProgressDialog(context);
                resetEverything();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },);

  }

  String details(String orderid) {
    return orderid;
  }
  String details1(String title) {
    return title;
  }
  void resetEverything() {
    // imageList.clear();
    NameController.text=("");
    ContactController.text=("");
    AddressController.text=("");
    PincodeController.text=("");
    setState(() {

    });
  }
}
class orderDetail extends TrendyOrder{
  static details(String orderid){
      return orderid;
  }
  static details1(String title) {
    return title;
  }

}



  //}
//}
