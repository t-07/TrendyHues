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
import 'dart:async';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendy_hues/services/usermanagement.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:trendy_hues/userScreens/loginLogout.dart';


class TrendyReset extends StatefulWidget {
  @override
  _TrendyResetState createState() => _TrendyResetState();
}

class _TrendyResetState extends State<TrendyReset> {
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  //final _key = GlobalKey<ScaffoldState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer _timer;
  TextEditingController __email = TextEditingController();
  TextEditingController __password = TextEditingController();
  TextEditingController __passwordnew = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 300,right: 230),
                          child: Center(
                            child: Text("Reset Signup",
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
                Form(
                  key: _formKey,
                  child: Padding(
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
                                    controller: __email,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern);
                                        if (!regex.hasMatch(value))
                                          return 'Please make sure your email address is valid';
                                        else
                                          return null;
                                      }
                                    },
                                    onChanged: (value){
                                      setState(() {
                                        _email= value;
                                      });}
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3.0),
                                child: TextFormField(
                                    obscureText: true,
                                    controller: __password,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "New Password",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        showSnackBar("The password field cannot be empty", scaffoldKey);
                                        return "The password field cannot be empty";
                                      }
                                      if(!value.contains("!")&& !value.contains("@") && !value.contains("%") && !value.contains("#") && !value.contains("*") )
                                      {
                                        showSnackBar("the password is too weak", scaffoldKey);
                                        return "Special Characters are needed";
                                      }
                                      if(!value.contains("0")&& !value.contains("1") && !value.contains("2") && !value.contains("3") && !value.contains("4") && !value.contains("5") && !value.contains("6") && !value.contains("7") && !value.contains("8") && !value.contains("9"))
                                      {
                                        showSnackBar("the password is too weak", scaffoldKey);
                                        return "Add some digits";
                                      }
                                      else if (value.length < 8) {
                                        showSnackBar("the password has to be at least 8 characters long", scaffoldKey);
                                        return "the password has to be at least 8 characters long";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                      setState(() {
                                        _password = value;
                                      });
                                    }
                                ),
                              ),

                               Container(
                                  padding: EdgeInsets.all(3.0),
                                  child: TextFormField(
                                   obscureText: true,
                                      controller: __passwordnew,
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                    validator: (value) {
                                     if(!(__passwordnew.text==__password.text))
                                       {
                                         showSnackBar("The password does not match", scaffoldKey);
                                         return "The password does not match";
                                       }
                                    if (value.isEmpty) {
                                          showSnackBar("The password field cannot be empty", scaffoldKey);
                                           return "The password field cannot be empty";
                                       }
                                         if(!value.contains("!")&& !value.contains("@") && !value.contains("%") && !value.contains("#") && !value.contains("*") )
                                          {
                                            showSnackBar("the password is too weak", scaffoldKey);
                                            return "Special Characters are needed";
                                            }
                                    if(!value.contains("0")&& !value.contains("1") && !value.contains("2") && !value.contains("3") && !value.contains("4") && !value.contains("5") && !value.contains("6") && !value.contains("7") && !value.contains("8") && !value.contains("9"))
                                 {
                                    showSnackBar("the password is too weak", scaffoldKey);
                                   return "Add some digits";
                                 }
                                 else if (value.length < 8) {
                                  showSnackBar("the password has to be at least 8 characters long", scaffoldKey);
                                   return "the password has to be at least 8 characters long";
                                 }
                                 return null;
                                  },
                                  onChanged: (value){
                                    setState(() {
                                        _password = value;
                                      });
                                  }
                               ),
                             )


                            ],
                          ),
                        ),
                        SizedBox(height: 30,),

                        RaisedButton(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          textColor: Colors.white,
                          elevation: 7.0,
                          child: Text('Change Password'),
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              if(EmailValidator.validate((_email))){
                                FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: _email,);
                                     {
                                      Fluttertoast.showToast(msg: "Follow the instructions in your email",backgroundColor: Colors.red);
                                  displayProgressDialog(context);
                                  _timer = new Timer(const Duration(seconds: 20),(){
                                    setState(() async {
                                      Fluttertoast.showToast(msg: "password has been changed successfully",backgroundColor: Colors.red);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context, new MaterialPageRoute(builder:(context)=> new TrendyLogin()),);

                                    });
                                  });
                                }
                                  //  .catchError((e) {
                                //  Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.red);
                                //  print("exceptionnnnnnnnnnnnnn");
                                //  print(e);
                               // }
                               // );
                              }}
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }}
/*bool validate() {
   bool isComplient=false;
   bool hasUppercase= false;
   bool hasLowercase= false;
   bool hasdigits = false;
   bool hasSpecialCharacters = false;
   var character='';
   var i=0;
   print("heloooooooooooooooooooooooooooooooooooooooooo");
   print(__password.text);
   if(! __password.text.isNotEmpty) {
     hasSpecialCharacters = __password.text.contains(new RegExp(r'[!@#&%^&*(),.?":{}|<>]'));
     while (i < __password.text.length) {
       character = __password as String;
       print(character);

   if(isDigit(character,0)){
     hasdigits=true;
   } else{
   if(character==character.toUpperCase()) {
   hasUppercase=true;
   }
   if(character==character.toLowerCase()) {
   hasLowercase = true;
   }
   }
   i++;
 }
 }
   isComplient = hasdigits & hasUppercase & hasLowercase & hasSpecialCharacters;
   return isComplient;
}
bool isDigit(String s,int index)=> "0".compareTo(s[index]) <= 0 && "9".compareTo(s[index]) >= 0;*/


