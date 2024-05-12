import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'package:trendy_hues/userScreens/loginLogout.dart';
import 'package:trendy_hues/userScreens/order.dart';
class TrendyCart extends StatefulWidget {

  String itemName;
  String itemImage;
  String itemSubName;
  String itemDescription;
  String itemPrice;
  List itemImages;
  double itemRating;

  TrendyCart({

    this.itemName,
    this.itemImage,
    this.itemRating,
    this.itemPrice,
    this.itemDescription,
    this.itemImages,
    this.itemSubName,
  });


  @override
  _TrendyCartState createState() => _TrendyCartState();
}

/*List<DropdownMenuItem<String>> dropDownColors;
String selectedColor;
List<String> colorList = new List();

List<DropdownMenuItem<String>> dropDownSizes;
String selectedSize;
List<String> sizeList = new List();

List<DropdownMenuItem<String>> dropDownCategories;
String selectedCategory;
List<String> categoryList = new List();*/


Map<int, File> imagesMap = new Map();

TextEditingController productqtyController = new TextEditingController();
TextEditingController nameController = new TextEditingController();
User firebaseUser = FirebaseAuth.instance.currentUser;
final scaffoldKey = new GlobalKey<ScaffoldState>();
String data;
String data1;
class _TrendyCartState extends State<TrendyCart> {



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
    data = widget.itemName;
    data1 = widget.itemPrice;
  }



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        //backgroundColor: Colors.transparent,
        backgroundColor: Color(0XFF26C6DA),
        elevation: 15.0,
        title: new Text("My Cart",
            style: TextStyle(
                fontFamily: 'Montseerat',
                fontSize: 18.0, color:
            Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          )
        ],
        // centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      /*body: ListView(
        children: [
         Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height-82.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            Positioned(
              top: 30.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height-100,
                width: MediaQuery.of(context).size.width,
              ),
            ),

            Positioned(
              top: 30.0,
              right: 0,
              left: (MediaQuery.of(context).size.width /2)-100,
                child: Container(
                  decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                     boxShadow: <BoxShadow>[
                       BoxShadow(
                        color: Colors.black,
                         offset: Offset(1.0,6.0)
              ),
             ],

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45.0),
                   //     topRight: Radius.circular(45.0),
                      ),
                    image: DecorationImage(
                      image: new NetworkImage(widget.itemImage),
                      fit: BoxFit.fill,
                    )
                  ),
                  height: 300,
                  width: 300,
                ),
              ),
          ],
        )
      ],
    ),
    );*/
      body: Column(
        children: [
          SizedBox(height: 10,),
          new Container(
            alignment: Alignment.topLeft,
            height: 100.0,
            width: 600.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    alignment: Alignment.topLeft,
                    image: new NetworkImage(widget.itemImage),
                    fit: BoxFit.fitHeight),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(10.0),
                  bottomLeft: new Radius.circular(10.0),
                )
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 90,),
                Text(widget.itemName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.red,

                ),),
                SizedBox(height: 50,width: 20,),
                Text("INR " + widget.itemPrice,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),),
                SizedBox(width: 100,),
                IconButton(
                  color: Colors.teal,
                  icon: Icon(Icons.check_circle_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ),
          Divider(thickness: 3,),


          SizedBox(height: 10,),
          new Container(
              alignment: Alignment.topLeft,
              height: 100.0,
              width: 600.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      alignment: Alignment.topLeft,
                      image: NetworkImage("https://images-na.ssl-images-amazon.com/images/I/616Gr2NqMeL._UL1500_.jpg"),
                      //AssetImage('assets/image/background.png'),
                      fit: BoxFit.fitHeight),
                  borderRadius: new BorderRadius.only(
                    bottomRight: new Radius.circular(10.0),
                    bottomLeft: new Radius.circular(10.0),
                  )
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 100,),
                  Text("Heels",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.red,

                    ),),
                  SizedBox(height: 50,width: 40,),
                  Text("INR  2000" ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),),
                  SizedBox(width: 100,),
                  IconButton(
                    color: Colors.teal,
                    icon: Icon(Icons.check_circle_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
          ),

          Divider(thickness: 3,),

          ],
      ),
      /*floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0XFF26C6DA),
            onPressed: () {
              if(firebaseUser!=null){
                Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyCart(),),);
              }
              else{Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),));};
              //Navigator.pushNamed(context, '/cart');
            },
            child: new Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.red,
            child: new Text(
              "0",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ],
      ),*/

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /*bottomNavigationBar: new BottomAppBar(
        //color: Colors.black,
        //elevation: 40.0,
        //notchMargin: 1000000,
        //shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Color(0XFF26C6DA)),
          child: new Container(
            width: (screenSize.width - 10) / 2,
            child: SizedBox(
              height: 80,
              child: RaisedButton(
                onPressed: () async {
                  if (await FirebaseAuth.instance.currentUser!= null)
                  {

                    if (selectedColor == "Select a color") {
                      Fluttertoast.showToast(msg: 'Fill the required fields',backgroundColor: Colors.red);

                      return;
                    }

                    if (selectedSize == "Select a size") {
                      Fluttertoast.showToast(msg: 'Fill the required fields',backgroundColor: Colors.red);

                      return;
                    }

                    if(productqtyController.text == "")
                    {
                      Fluttertoast.showToast(msg: 'Fill the required fields',backgroundColor: Colors.red);
                      return;
                    }
                    String num= productqtyController.text;
                    int num2=int.parse(num);
                    if(num2 >= 30) {
                      print(num2);
                      Fluttertoast.showToast(
                          msg: 'You cannot order products in bulk.This is applicable to sellers.',
                          backgroundColor: Colors.red);
                      return;
                    }
                    // verify;
                    Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyOrder(),),);
                  }else{
                    Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),),);
                  }
                },
                color: Color(0XFF26C6DA),

                child: new Text(
                  "ORDER NOW",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),*/
    );
    /*body: Column(
        children: [
          Expanded(
            child: Column(),
          ),
          Container(
            alignment: Alignment.topRight,
            height: size.height*0.8,
            width: size.width*0.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
                image: NetworkImage(widget.itemImage),
              )
            ),
          )
        ],

      ),*/
    // ); */
  }

  void changedDropDownColor(String selectedSize) {
    setState(() {
      selectedColor = selectedSize;
      //return widget.itemName;

    });
  }
  void changedDropDownSize(String selected) {
    setState(() {
      selectedSize = selected;
    });
  }

/*verify() async {
     print("hellooooooooooooooooooooooooooooooooooooooooo");

     if (selectedColor == "Select a color") {
       showSnackBar("Please select a color", scaffoldKey);
       return;
     }

     if (selectedSize == "Select a size") {
       showSnackBar("Please select a size", scaffoldKey);
       return;
     }

     if(productqtyController == null)
       {
         showSnackBar("Please give the quantity", scaffoldKey);
         return;
       }
   }*/
}

class itemdetails
{

  static String giveColor () {
    return(selectedColor);
  }

  static giveSize () {
    return (selectedSize);
  }

  static giveQty () {
    return (productqtyController.text);
  }


}

