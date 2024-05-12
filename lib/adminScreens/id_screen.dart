/*import 'package:flutter/material.dart';
import 'package:flutter_project/tools/app_methods.dart';
import 'package:flutter_project/tools/app_tools.dart';
import 'package:flutter_project/tools/app_data.dart';
import 'package:flutter_project/tools/firebase_methods.dart';

class TrendySignup extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<TrendySignup>  {
  //GlobalKey<FormState> formkey= GlobalKey<FormState>();
  TextEditingController fullname = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController re_password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  //-----------------change--------------------
  AppMethods appMethods = new FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Sign Up"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[

            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Full Name",
                textIcon: Icons.person,
                controller: fullname
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Phone Number",
                textIcon: Icons.phone,
                textType: TextInputType.number,
                controller: phoneNumber),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Re-Password",
                textIcon: Icons.lock,
                controller: re_password),

            appButton(
                btnTxt: "Create Account",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }


  verifyLoggin() async {
    if(fullname.text == ""){
      showSnackBar("Fullname cannot be empty", scaffoldKey);
      return;
    }

    if(phoneNumber.text == ""){
      showSnackBar("Phone cannot be empty", scaffoldKey);
      return;
    }

    if(email.text == ""){
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if(password.text == ""){
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    if(re_password.text == ""){
      showSnackBar("Re-Password cannot be empty", scaffoldKey);
      return;
    }

    if(password.text != re_password.text){
      showSnackBar("Passwords don't match", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    //------------------------------change//
    AppMethods obj;
    String response = await obj.createUserAccount(
       // fullname: fullname.text.toLowerCase(),
        //phone: phoneNumber.text,
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase());

    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    }
  }
}*/

//import 'dart:html';
/*import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/tools/app_tools.dart';
import 'package:flutter_project/tools/app_methods.dart';
import 'package:flutter_project/tools/app_data.dart';
import 'package:flutter_project/tools/firebase_methods.dart';
import 'package:flutter_project/userScreens/signup.dart';
import 'package:flutter_project/tools/progressdialog.dart';
import 'package:flutter_project/userScreens/MainPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {


  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;

  //--------------------------------------change//
   AppMethods appMethods = new FirebaseMethods();
/*
  final GoogleSignIn googleSignIn= new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
    }

    setState(() {
      loading=false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    getCurrentUser() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid.toString();
      final displayName = user.displayName;
      return uid;
    }


    if (firebaseAuth != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseAuth.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseAuth.uid)
            .setData({
          "id": firebaseAuth.uid,
          "username": firebaseAuth.displayName,
          "profilePicture": firebaseAuth.photoUrl
        });

        await preferences.setString(("id"), firebaseAuth.uid);
        await preferences.setString(("username"), firebaseAuth.displayName);
        await preferences.setString(("photoUrl"), firebaseAuth.displayName);
      }
    } else {
      await preferences.setString(("id"), documents[0]['id']);
      await preferences.setString(("username"), documents[0]['username']);
      await preferences.setString(("photoUrl"), documents[0]['photoUrl']);

      Fluttertoast.showToast(msg: "hello");
      setState(() {
        loading = false;
      });
    }
  }
*/



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Login"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Login",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }*/
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // decoration:BoxDecoration(
      //gradient: LinearGradient(
       // colors: [
         // Colors.lightGreenAccent,
         // Colors.white
       // ]
      //)
      //),
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new TrendySignup()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLoggin() async {
    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        showDialog(context: context,
        builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("NO user found for that email"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }else if(e.code=='wrong-password'){
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Wrong password provided"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    //AppMethods obj;
    // String response = await obj.logginUser(
     //   email: email.text.toLowerCase(), password: password.text.toLowerCase());
   // if (response == successful) {
     // closeProgressDialog(context);
     // Navigator.of(context).pop(); //------------Add true in ()
    //} else {
     // closeProgressDialog(context);
      //showSnackBar(response, scaffoldKey);
    //}
  }

}*/

/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trendy_hues/adminScreens/admin_home.dart';
import 'package:trendy_hues/services/usermanagement.dart';
import 'package:trendy_hues/adminScreens/admin_home.dart';
class TrendyVerify extends StatefulWidget {
  @override
  _TrendyVerifyState createState() => _TrendyVerifyState();
}

class _TrendyVerifyState extends State<TrendyVerify> {
  //String _email;
  //String _password;
  final _mycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _mycontroller,
                    decoration: InputDecoration(hintText: 'Unique Id'),
                    // onChanged: (value){
                    // setState(() {
                    // _email= value;
                    //});
                    // }
                  ),
                  /*    SizedBox(height: 15.0),
                  TextField(
                      decoration:  InputDecoration(hintText: 'Password'),
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {

                    },
                  ),
                  SizedBox(height: 15.0),
                  Text("Don't have an account ?"),
                  SizedBox(height: 10.0),*/
                  RaisedButton(
                      child: Text('Verify'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: () { _mycontroller.text=='90909090' ? AdminHome() : 'invalid';
                        //Navigator.of(context).push(new MaterialPageRoute(
                        //  builder: (context) => new AdminHome();
                        //FirebaseAuth.instance.createUserWithEmailAndPassword(
                        //  email: _email,
                        // password: _password)
                        // .then((signedInUser) {
                        //  UserManagement().storeNewUser(signedInUser, context);
                      })
                  //  .catchError((e) {
                  //print(e);
                  //});
                  //},
                  //),
                ],
              )
          ),
        )
    );
  }
}*/


/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';

import 'MainPage.dart';

class TrendySignup extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<TrendySignup>  {
  //GlobalKey<FormState> formkey= GlobalKey<FormState>();
  TextEditingController fullname = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController re_password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  //-----------------change--------------------
  AppMethods appMethods = new FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Sign Up"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[

            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Full Name",
                textIcon: Icons.person,
                controller: fullname
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Phone Number",
                textIcon: Icons.phone,
                textType: TextInputType.number,
                controller: phoneNumber),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Re-Password",
                textIcon: Icons.lock,
                controller: re_password),

            appButton(
                btnTxt: "Create Account",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }


  verifyLoggin() async {
    if(fullname.text == ""){
      showSnackBar("Fullname cannot be empty", scaffoldKey);
      return;
    }

    if(phoneNumber.text == ""){
      showSnackBar("Phone cannot be empty", scaffoldKey);
      return;
    }

    if(email.text == ""){
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if(password.text == ""){
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    if(re_password.text == ""){
      showSnackBar("Re-Password cannot be empty", scaffoldKey);
      return;
    }

    if(password.text != re_password.text){
      showSnackBar("Passwords don't match", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
      String response = await appMethods.createUserAccount(
       fullname: fullname.text.toLowerCase(),
      phone: phoneNumber.text,
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase());
      //MainPage();

        print("Priyaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");


    if (response == 'successful') {
      print("ooooooooooooooooooooooooooooooooooooo");
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
      Navigator.of(context).pop(true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MainPage()));



    } else {
      closeProgressDialog(context);
      print('elseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeepart');
      showSnackBar(response, scaffoldKey);
    }

  }
}*/

//firebase code
/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trendy_hues/services/usermanagement.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
class TrendySignup extends StatefulWidget {
  @override
  _TrendySignupState createState() => _TrendySignupState();
}

class _TrendySignupState extends State<TrendySignup> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value){
                        setState(() {
                          _email= value;
                        });
                      }
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                      decoration:  InputDecoration(hintText: 'Password'),
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      }
                  ),
              //    SizedBox(height: 20.0),
                //  RaisedButton(
                  //  child: Text('Login'),
                    //color: Colors.blue,
                    //textColor: Colors.white,
                    //elevation: 7.0,
                    //onPressed: () {

                   // },
                  //),
                  SizedBox(height: 15.0),
                 // Text("Don't have an account ?"),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Sign up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _email,
                          password: _password)
                          .then((signedInUser) {
                        UserManagement().storeNewUser(signedInUser.user, _password, context);
                      })
                          .catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ],
              )
          ),
        )
    );
  }
}*/

//----------------------------------------layout changes
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trendy_hues/adminScreens/admin_home.dart';
import 'package:trendy_hues/services/usermanagement.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';


class TrendyVerify extends StatefulWidget {
  @override
  _TrendyVerifyState createState() => _TrendyVerifyState();
}

class _TrendyVerifyState extends State<TrendyVerify> {
  final _mycontroller = TextEditingController();

  //String _email;
  //String _password;
  //final _formKey = GlobalKey<FormState>();
  //final _key = GlobalKey<ScaffoldState>();
  //final scaffoldKey = new GlobalKey<ScaffoldState>();

 // TextEditingController __email = TextEditingController();
  //TextEditingController __password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      /* Positioned(
                        left: 30,
                        width: 80,
                        height: 500,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/image/2.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-2.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        ),
                      ),*/
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 300,right: 230),
                          child: Center(
                            child: Text("Verify",
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                  obscureText: true,
                                  controller: _mycontroller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Unique id",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                 /* validator: (value) {
                                    if (value.isEmpty) {
                                      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your email address is valid';
                                      else
                                        return null;
                                    }
                                  },*/
                                 // onChanged: (value){
                                   // setState(() {
                                     // _email= value;
                                   // });}
                              ),
                            ),
                           /* Container(
                              padding: EdgeInsets.all(3.0),
                              child: TextFormField(
                                  controller: __password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                  validator: (value) {
                                    print("jujujujujujujujujujujujujujujujujujuuj");
                                    if (value.isEmpty) {
                                      print("jujujujujujujujujujujujujujujujujujuuj");
                                      showSnackBar("The password field cannot be empty", scaffoldKey);
                                      return "The password field cannot be empty";
                                    } else if (value.length < 8) {
                                      showSnackBar("the password has to be at least 8 characters long", scaffoldKey);
                                      // return "the password has to be at least 8 characters long";
                                    }
                                    return "kukukukukukukukukukukuuuuuuuuuuuuuuuuuuuuuuuu";
                                  },
                                  onChanged: (value){
                                    setState(() {
                                      _password = value;
                                    });
                                  }
                              ),
                            )*/
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      //Container(
                      //height: 50,
                      //decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(40),
                      // gradient: LinearGradient(
                      //   colors: [
                      //   Color.fromRGBO(143, 148, 251, 1),
                      // Color.fromRGBO(143, 148, 251, .6),
                      // ]
                      // )
                      //),
                      /*child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Color.fromRGBO(143, 148, 251, 1),
                          textColor: Colors.white,
                          elevation: 7.0,
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _email,
                                password: _password).then((FirebaseUser) {
                              Navigator.of(context).pushReplacementNamed('/mainPage');
                            }).catchError((e) {
                              print(e);
                            });

                          },
                        ),*/
                      //),
                      // SizedBox(height: 30,),
                      // Text("Don't have an account ?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
                      //SizedBox(height: 10.0),
                      RaisedButton(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        textColor: Colors.white,
                        elevation: 7.0,
                        child: Text('Verify'),
                         onPressed: () { fnc(context);}

                        /*onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password)
                              .then((signedInUser) {
                            UserManagement().storeNewUser(signedInUser.user, _password, context);
                          })
                              .catchError((e) {
                            showSnackBar((e.toString()), scaffoldKey);
                            print(e);
                          });
                        },*/
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
/*
  void fnc(context) {
    if (_mycontroller.text.compareTo("90909090") == null) {
      print("killerrrrrrrrrrrrrr");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHome()));
    }
    else {
      alertdialog();
    }
  }*/

   Future <void> alertdialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible:false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Alert Message",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("You are trying to access the other party services with invalid credentials"),
                ],
              )
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },);
  }

  void fnc(BuildContext context) {
    if (_mycontroller.text.compareTo("adminpanel") == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHome()));
    }
    else if(_mycontroller.text.compareTo("adminpanel") != null){
      alertdialog();
    }
  }

}


