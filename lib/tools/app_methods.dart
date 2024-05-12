import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


abstract class AppMethods  {
  Future<String> logginUser({String email, String password});
  Future<String> createUserAccount(
      {String fullname, String phone, String email, String password});
  Future<bool> logOutUser();
  Future<DocumentSnapshot> getUserInfo(String userid);
  Future<String> addNewProduct({Map newProduct, String cat});
  Future<String> addOrder({Map newOrder});
  Future<List<String>> uploadProductImages(
      {List<File> imageList, String docID, String cat});
  Future<bool> updateProductImages({
  String docID,
    List<String> data,
    String cat,
});
}


