//import 'dart:io';

//import 'dart:html';

//import 'package:flutter/cupertino.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/adminScreens/id_screen.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';
import 'package:trendy_hues/userScreens/aboutUs.dart';
import 'package:trendy_hues/userScreens/cart.dart';
import 'package:trendy_hues/userScreens/history.dart';
//import 'package:flutter_project/userScreens/aboutUs.dart';
//import 'package:flutter_project/userScreens/cart.dart';
//import 'package:flutter_project/userScreens/delivery.dart';
//import 'package:flutter_project/userScreens/favorites.dart';
//import 'package:flutter_project/userScreens/history.dart';
import 'package:trendy_hues/userScreens/loginLogout.dart';
//=import 'package:flutter_project/userScreens/messages.dart';
//import 'package:flutter_project/userScreens/profile.dart';
import 'package:trendy_hues/tools/Store.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:trendy_hues/tools/horizontalList.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'package:provider/provider.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/userScreens/notifications.dart';
import 'package:trendy_hues/userScreens/order.dart';
import 'package:trendy_hues/userScreens/signup.dart';
import 'package:trendy_hues/adminScreens/id_screen.dart';
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    future: Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
      routes: <String, WidgetBuilder> {
      //  '/favorites': (context) =>Trendyfavorites(),
       // '/messages': (context)=>Trendymessages(),
        //'/cart': (context)=>TrendyCart(),

        //'/history': (context)=> TrendyHistory(),
        //'/profile': (context)=> TrendyProfile(),
        //'/delivery': (context)=> TrendyDelivery(),
        //'/aboutUs' : (context)=> TrendyaboutUs(),
        '/notifications': (context)=> TrendyNotifications(),
        '/itemDetails' :(context)=> TrendyitemDetails(),
        '/loginLogout': (context)=> TrendyLogin(),
        '/signup' : (BuildContext context) => new TrendySignup(),
        '/order' : (context) => new TrendyOrder(),
      },
    );
  }
}
class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
  /*String accName="";
  String accemail="";
  String accphotoURL="";
  bool isLoggedIn;
  AppMethods appMethods = new FirebaseMethods();
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  Future getCurrentUser() async {

    accName= await getDataLocally(key: acctFullName);
    accemail= await getDataLocally(key: userEmail);
    accphotoURL= await getDataLocally(key: photoURL);
    isLoggedIn= await getBoolDataLocally(key: loggedIN);
    accName == null ? accName =" " : accName;
    accemail == null ? accemail = "": accemail;
    setState(() {});
  }*/
  //AppMethods appMethods = new FirebaseMethods();
  FirebaseFirestore firestore=Firestore.instance;
  @override
  Widget build(BuildContext context) {

    this.context=context;
    // It provides total height and width of screen
    Size size = MediaQuery.of(context).size;
    Widget image_carousel=new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        borderRadius: true,
        images: [
          AssetImage('assets/image/carou1.jpg'),
          AssetImage('assets/image/carou2.jpg'),
          AssetImage('assets/image/carou3.jpg'),
          AssetImage('assets/image/carou4.jpg'),
          AssetImage('assets/image/carou5.jpg'),
          AssetImage('assets/image/carou6.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
    User firebaseUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade400,
        actions: <Widget>[
          /*IconButton(
            icon: new Icon(
              Icons.favorite,
              color: Colors.white,
              size: 30,
            ),
            onPressed: (){Navigator.pushNamed(context,'/favorites');
            },
          ),*/

          Row(
            //alignment: Alignment.topLeft,
            children: <Widget>[
              Image.asset('assets/image/ball.png'),
              SizedBox(width: 30),

              SizedBox(width: 10),
              Image.asset('assets/image/ball.png'),


              /* IconButton(
                icon: new Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/messages');
                },
              ),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: new Text(
                  "0",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              )*/
            ],
          ),
          //),
        ],
      ),
      /*body: new StreamBuilder(
        stream: firestore.collection(appProducts).snapshots(),
        builder: (context,snapshot) {
          if(!snapshot.hasData) {
            return new Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor
                ),
              )
            );
          }else{
            final int dataCount= snapshot.data.documents.length;
            print("data count $dataCount");
            if(dataCount==0) {
              noDataFound();
            }else{
              return new GridView.builder(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: dataCount,
                itemBuilder: buildProducts,
              );
            }
          }
        }
      ),*/
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: size.height*0.1,
                  child: Stack(
                      children: <Widget>[
                        Container(
                            height: size.height * 0.1-5,
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(80),
                                  bottomRight: Radius.circular(80),
                                )
                            )
                        ),
                        Row(
                          children: [
                            SizedBox(width: 300),
                            Image.asset('assets/image/ball.png'),
                            SizedBox(width: 30),
                            Image.asset('assets/image/ball.png'),

                            //Image.asset('assets/image/gra.png'),
                            //SizedBox(width: 30),
                            //Image.asset('assets/image/gra.png'),
                          ],
                        )
                        /*Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,10),
                                    blurRadius: 50,
                                    color: Colors.white10.withOpacity(0.23),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: " What are you looking for..?",
                                        hintStyle: TextStyle(
                                          color: Colors.black12.withOpacity(0.5),
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Image.asset('assets/image/search3.png'),
                                ],
                              ),
                            )
                        ),*/
                      ]
                  ),
                ),
              ],
            ),
            image_carousel,
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Categories',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                      color: Colors.black.withAlpha(180),
                      // color: Colors.white,
                    ),
                  ),
                )
            ),

            TrendyhorizontalList(),

            Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Featured Products',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                      color: Colors.black.withAlpha(180),
                    ),
                  ),
                )
            ),

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection(appProducts).snapshots(),
                builder: (context,snapshot) {
                  if(!snapshot.hasData) {
                    return new Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor
                          ),
                        )
                    );
                  }else if(snapshot.hasData){
                    final int dataCount= snapshot.data.documents.length;
                    print("data count $dataCount");
                    if(dataCount==0) {
                      noDataFound();
                    }else{
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 07),
                        height: size.height*0.78,
                        child: new Center(
                          child: new Column(
                            children: [
                              new Flexible(
                                  child:new GridView.builder(
                                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                                  itemCount: dataCount,
                                   itemBuilder: (context, index){
                                    final DocumentSnapshot document=snapshot.data.docs[index];
                                    return buildProducts(context, index,document);
                                   },
                            ),),]
                          ),
                        ),
                      );
                    }
                  }
                }
            ),
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 07),
              height: size.height*0.78,
              child: new Center(
                  child: new Column(
                    children: [
                      new Flexible(
                          child: new GridView.builder(
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: storeItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (context) => new TrendyitemDetails(
                                        itemImage: storeItems[index].itemImage,
                                        itemName: storeItems[index].itemName,
                                        itemPrice: storeItems[index].itemPrice,
                                        itemRating: storeItems[index].itemRating,
                                      )));
                                },
                                child: new Card(

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: new Stack(
                                    alignment: FractionalOffset.bottomCenter,
                                    children: [

                                      new Container(
                                        child: new Image.network(storeItems[index].itemImage),
                                      ),

                                      new Container(
                                          alignment: FractionalOffset.topRight,
                                          //children: [
                                          //Positioned(
                                          //bottom:50,
                                          child :IconButton(
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Colors.pinkAccent,
                                              ),
                                              onPressed: () {})
                                      ),
                                      //],
                                      // ),

                                      new Container(
                                        height: 35.0,
                                        color: Colors.black.withAlpha(150),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new Text(storeItems[index].itemName,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              new Text("Rs.${storeItems[index].itemPrice}",
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      )
                    ],
                  )
              ),
              //  ),
              // ),
            ),*/
          ],
        ),
      ),
      /*floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: [
          /*new FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: (){Navigator.pushNamed(context,'/cart');
            },
            child: new Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.red,
            child: new Text(
              "0",
              style: new TextStyle(color:Colors.white, fontSize: 12.0),
            ),
          )*/
        ],
      ),*/

      drawer: new Drawer(
        child: new Column(
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text(/*accName*/ 'Hey!',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              accountEmail: new Text(firebaseUser!=null ? firebaseUser.email : "",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.person,
                  size: 40.0,
                ),
              ),
            ),

            new ListTile(
              onTap: () async{
                if (await FirebaseAuth.instance.currentUser!= null)
                {
                  Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyHistory(),),);
                  //  Navigator.pushNamed(context,'/notifications');
                }else{
                  Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),),);
                }
                //Navigator.pushNamed(context,'/history');

              },
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Order History",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            /*new ListTile(
              onTap: (){Navigator.pushNamed(context,'/profile');
              },
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Profile Settings",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            new ListTile(
              onTap: (){Navigator.pushNamed(context,'/delivery');
              },
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Delivery Address ",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),*/
            new Divider(),
            new ListTile(
              onTap: (){ Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new TrendyAboutUs()));
              },
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("About Us",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            new ListTile(
              onTap: () async {
                checkIfLoggedIn();
                //---------------------------1st lime---//
               // Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),),);
              },
                /*User firebaseUser = FirebaseAuth.instance.currentUser;
                Widget firstWidget;
                if(firebaseUser != null)
                  {print("87787787787878778777887888888888888888888888888888888888");
                  MainPage();}
                else{
                  //TrendyLogin();
                  Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),),);
                  print("ELSE PARTR---------------------------------------------");}
                },
               // if (await FirebaseAuth.instance.currentUser != null)
                //if(isLoggedIn == false)
               // {

                 // Navigator.push(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin(),),);

                  //  Navigator.pushNamed(context,'/notifications');
                //}else{
                  //Navigator.push(context, new MaterialPageRoute(builder:(context)=> new MainPage(),),);
               // }

              //},*/

               // fnc();
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text(firebaseUser!= null ? "Logout" : "Login",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            new Divider(),
            new ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyVerify()));
              },
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("admin",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   checkIfLoggedIn() async {

    User firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstwidget;
    if (firebaseUser != null)
      //firstwidget= MainPage();
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
       // Navigator.of(context).pushReplacementNamed('/MainPage');
      }).catchError((e) {
        print(e);
      });
    else
      {
        Navigator.pop(context);
       //  Navigator.of(context).pushReplacementNamed('/loginLogout');
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyLogin()));
       // firstwidget=TrendyLogin();
      //Navigator.pushNamed(context, '/loginLogout');
     // Navigator.of(context).pushReplacementNamed('/loginLogout');
      print("flutterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");}
   }

  Widget noDataFound() {
      return new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Icon(
                Icons.find_in_page,
                color:Colors.black45,
                size: 80.0,
              ),
              new Text("No Product available yet",
              style:new TextStyle(color:Colors.black45,fontSize: 20.0),),
              new SizedBox(height:10.0),
              new Text("Please check back Later",
              style: new TextStyle(color:Colors.red, fontSize: 14.0),)
            ],
          )
        )
      );
  }

  Widget buildProducts(BuildContext context, int index, DocumentSnapshot document){
    List productImage =document[productImages];
   // print(snapshot[productTitle]);
    return new GestureDetector(
      onTap: () {
         Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new TrendyitemDetails(
              itemImage: productImage[0],itemImages: productImage,
              itemName: document[productTitle],
              itemSubName: document[productCat],
              itemPrice: document[productPrice],
              itemDescription: document[productDesc],
              itemRating: storeItems[index].itemRating,
            )));


      },
      child: new Card(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
        ),
        child: new Stack(
          alignment: FractionalOffset.bottomCenter,
          children: [
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit:BoxFit.fitWidth,
                  image: new NetworkImage(productImage[0])
                )
              ),
              //child: new Image.network(storeItems[index].itemImage),
            ),

            new Container(
                alignment: FractionalOffset.topRight,
                //children: [
                //Positioned(
                  //bottom:50,
                child :IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: () {})
            ),
           // ],
            // ),

            new Container(
              height: 35.0,
              width:200.0,
              color: Colors.black.withAlpha(150),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Text("${document[productTitle]}         ",
                      //storeItems[index].itemName,
                      style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),


                    new Text(

                      "Rs.${document['productPrice']}",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }


/*
  openAdmin() {
    Route route= MaterialPageRoute(builder: (_)=> TrendyVerify());
    Navigator.pushReplacement(context, route);
    //Navigator.pop(context);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyVerify()));
  }
*/



     //Navigator.of(context).push(new CupertinoPageRoute(builder: (BuildContext context) => new TrendyLogin()));
    /*if(isLoggedIn== false) {
      bool response = await Navigator.of(context).push(new CupertinoPageRoute(builder: (BuildContext context) => new TrendyLogin()));
      if(response == true) getCurrentUser();
      return ;

    }
    bool response = await appMethods.logOutUser();
    if(response == true) getCurrentUser();
  }*/
}


