import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/cart.dart';
import 'package:trendy_hues/userScreens/loginLogout.dart';
import 'package:trendy_hues/userScreens/order.dart';
class TrendyitemDetails extends StatefulWidget {

  String itemName;
  String itemImage;
  String itemSubName;
  String itemDescription;
  String itemPrice;
  List itemImages;
  double itemRating;

  TrendyitemDetails({

    this.itemName,
    this.itemImage,
    this.itemRating,
    this.itemPrice,
    this.itemDescription,
    this.itemImages,
    this.itemSubName,
  });


  @override
  _TrendyitemDetailsState createState() => _TrendyitemDetailsState();
}

List<DropdownMenuItem<String>> dropDownColors;
String selectedColor;
List<String> colorList = new List();

List<DropdownMenuItem<String>> dropDownSizes;
String selectedSize;
List<String> sizeList = new List();

List<DropdownMenuItem<String>> dropDownCategories;
String selectedCategory;
List<String> categoryList = new List();


Map<int, File> imagesMap = new Map();

TextEditingController productqtyController = new TextEditingController();
TextEditingController nameController = new TextEditingController();
User firebaseUser = FirebaseAuth.instance.currentUser;
final scaffoldKey = new GlobalKey<ScaffoldState>();
String data;
String data1;
 class _TrendyitemDetailsState extends State<TrendyitemDetails> {



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
          title: new Text("Details",
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
        body: new Stack(
          alignment: Alignment.topCenter,
          children: [
            new Container(
              height: 300.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(widget.itemImage),
                      fit: BoxFit.fitHeight),
                  borderRadius: new BorderRadius.only(
                    bottomRight: new Radius.circular(120.0),
                    bottomLeft: new Radius.circular(120.0),
                  )
              ),
            ),
            new Container(
              height: 300.0,
              decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: new BorderRadius.only(
                    bottomLeft: new Radius.circular(120.0),
                    bottomRight: new Radius.circular(120.0),
                  )
              ),
            ),
            new SingleChildScrollView(
              child: new Column(
                children: [
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Card(
                      margin: EdgeInsets.only(top: 250),
                      child: new Container(
                        width: screenSize.width,
                        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              widget.itemName,
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                            widget.itemSubName,
                            style: new TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                              ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    new Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ), new Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ), new Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ),
                                    new Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.0,
                                    ),

                                    new Text("                           "+"Price :  INR " + widget.itemPrice,
                                      style: new TextStyle(
                                          fontSize: 17.0, fontWeight: FontWeight.w500,color: Colors.red),
                                    ),
                                  ],),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  new Card(
                      child: new Container(
                        width: screenSize.width,
                        height: 150.0,
                        child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.itemImages.length,
                          itemBuilder: (context, index) {
                            return new Stack(
                              alignment: Alignment.center,
                              children: [
                                new Container(
                                  margin: new EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  height: 140.0,
                                  width: 100.0,
                                  child: new Image.network(
                                      widget.itemImages[index]),
                                ),
                                new Container(
                                  margin: new EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  height: 140.0,
                                  width: 100.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.grey.withAlpha(50)
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                  ),
                  new Card(
                      child: new Container(
                        width: screenSize.width,
                        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text("ABOUT THIS ITEM",
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w900),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              widget.itemDescription,
                              style: new TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      productDropDown(
                          textTitle: "Colors",
                          selectedItem: selectedColor,
                          dropDownItems: dropDownColors,
                          changedDropDownItems: changedDropDownColor),

                      productDropDown(
                          textTitle: "Sizes",
                          selectedItem: selectedSize,
                          dropDownItems: dropDownSizes,
                          changedDropDownItems: changedDropDownSize),

                      productTextField(
                          textTitle: "Quantity",
                          textType: TextInputType.number,
                          textHint: "Enter quantity",
                          controller: productqtyController

                      ),
                      new SizedBox(
                        height: 10.0,
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: new Stack(
          alignment: Alignment.topLeft,
          children: [
            FloatingActionButton(
              backgroundColor: Color(0XFF26C6DA),
              onPressed: () {
                if(firebaseUser!=null){
                 addItemToCart(widget.itemImage);
                //Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyCart(),),);
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
        ),

        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: new BottomAppBar(
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
        ),
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
  Widget addItemToCart(String itemImage) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new TrendyCart(
          itemImage: widget.itemImage,
          itemName: widget.itemName,
          itemSubName: widget.itemSubName,
          itemPrice:widget.itemPrice,
          itemDescription: widget.itemDescription,
          itemRating: widget.itemRating,
        )));     /*return Scaffold(
       body: Container(
         height: 300.0,
         decoration: new BoxDecoration(
             image: new DecorationImage(
                 image: new NetworkImage(widget.itemImage),
                 fit: BoxFit.fitHeight),
             borderRadius: new BorderRadius.only(
               bottomRight: new Radius.circular(120.0),
               bottomLeft: new Radius.circular(120.0),
             )
         ),
       ),
     );*/
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

