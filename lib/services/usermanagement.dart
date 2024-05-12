import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';

class UserManagement{
  storeNewUser(user,password,context) {
    Firestore.instance.collection('users').add({
      'email' : user.email,
      'password' : password,
      'uid' : user.uid,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
     // Navigator.of(context).pushReplacementNamed("/mainPage");
    }).catchError((e) {
      print(e);
    });
  }


}