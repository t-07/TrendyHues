//import 'dart:js';

//import 'package:flutter/animation.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/Config/config.dart';
import 'package:trendy_hues/userScreens/loginLogout.dart';
import 'userScreens/MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

/*Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //EcommerceApp.auth=FirebaseAuth.instance;
  runApp(MyApp());
}*/

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Eczar'
      ),
      //home: MyHomePage(),
      home: SplashScreen(),
      routes: {
        '/mainPage': (context) =>MainPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    displaySplash();
  }
  displaySplash()
  {
    AlertDialog(
      title: Text("Error"),
      actions: [
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        })
      ],
    );
    Timer(Duration(seconds: 2), () async{
     /* AlertDialog(
        title: Text("Error"),
        backgroundColor: Colors.black,
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      );*/
    //  if(await EcommerceApp.auth.currentUser != null)
     // {
        Route route= MaterialPageRoute(builder: (_)=> mainPage());
        Navigator.pushReplacement(context, route);
      //}
     // else{
       // Route route= MaterialPageRoute(builder: (_)=> TrendyLogin());
       // Navigator.pushReplacement(context, route);
     // }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),

      body:Stack(
        //mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0,top: 0),
            //    child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[
            // Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/img.jpeg'),
                  fit:BoxFit.cover
              ),
            ),

          ),
          /*
                Positioned(
                  bottom: 10,
                  left: 100,
                  right: 100,
                  child: Center(
                    child: InkWell(
                      onTap: (){openMainPage();},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Text('Continue>>',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),),
                      ),
                    ),
                  ),
                ),*/
        ],
      ),
      // ),
      //],
      //),
    );

  }

  void openMainPage()
  {
    Navigator.pushNamed(context,'/mainPage');
  }
}

