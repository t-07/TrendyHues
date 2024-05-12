import 'dart:async';
import 'dart:convert';
//import 'dart:html';
//import 'dart:html' hide File;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:flutter/services.dart';
import 'package:trendy_hues/adminScreens/add_products.dart';
import 'package:http/http.dart' as http;
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';


 class FirebaseMethods implements AppMethods{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<String> createUserAccount({
    String fullname,
    String phone,
    String email,
    String password}) async{
    /*const url ='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCz3fsenTzkMUfqH-Gj2LDZFYT_5JeCnBE';
    final response = await http.post(url,body:json.encode({
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
    }
    ));
    final responseData =json.decode(response.body);
    print(responseData);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
    } catch(e){print(e);}*/
    //FirebaseAuth user;
    UserCredential userCredential;
    FirebaseUser user;

    try  {
      userCredential = (await auth.createUserWithEmailAndPassword(
          email: email, password: password));

    } on PlatformException catch (e) {
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print(e.details);
      return errorMSG(e.details);


    }

    try {
      if (user != null) {
        await firestore.collection(usersData).document(user.uid).setData({
          userID: user.uid,
          acctFullName: fullname,
          userEmail: email,
          userPassword: password,
          phoneNumber: phone

        });

        writeDataLocally(key: userID, value: user.uid);
        writeDataLocally(key: fullname, value: fullname);
        writeDataLocally(key: userEmail, value: userEmail);
        writeDataLocally(key: userPassword, value: password);
      }

    } on PlatformException catch (e) {
      print("shutupppppppppppppppppppppppppppppppppppp");
      //print(e.details);
      return errorMSG(e.details);
    }

    return user != null ? errorMSG("Error") : successfulMSG();

  }






/*
  on FirebaseAuthException catch(e){
  if(e.code == 'weak-password'){
  print("The password provided is too weak");
    if(userCredential!=null){
      await firestore.collection(usersData).document(userCredential.uid).setData({
    }),
    }
  }*/
/*
  @override
  Future<DocumentSnapshot> getUserInfo(String userid) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> logOutUser() {
    // TODO: implement logOutUser
    throw UnimplementedError();
  }

  @override
  Future<String> logginUser({String email, String password}) async{
    // TODO: implement logginUser
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password);
    print('----------------------------HELO-----------------------------------');
    if (userCredential == null) {
      notComplete();
    } else {
      complete();
    }

  }

  Future<bool> complete() async{
    return true;
  }

  Future<bool> notComplete() async{
    return false;
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
*/

  @override
  Future<String> logginUser({String email, String password}) async {
    // TODO: implement logginUser

    FirebaseUser user;
    try {
      user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)) as FirebaseUser;
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

      if (user != null) {
        print("*****************************************");
        DocumentSnapshot userInfo = await getUserInfo(user.uid);
        await writeDataLocally(key: userID, value: userInfo[userID]);
        await writeDataLocally(key: acctFullName, value: userInfo[acctFullName]);
        await writeDataLocally(key: userEmail, value: userInfo[userEmail]);
        await writeDataLocally(key: phoneNumber, value: userInfo[phoneNumber]);
        await writeDataLocally(key: photoURL, value: userInfo[photoURL]);
        await writeBoolDataLocally(key: loggedIN, value: true);
        print("99999999999999999999999999999999999999");
        print(userInfo[userEmail]);
      }
    } on PlatformException catch (e) {
      //print(e.details);
      return errorMSG(e.details);
    }

    return user == null ? errorMSG("Error") : successfulMSG();
  }

  Future<bool> complete() async {
    return true;
  }

  Future<bool> notComplete() async {
    return false;
  }

  Future<String> successfulMSG() async {
    return successful;
  }

  Future<String> errorMSG(String e) async {
    return e;
  }

  @override
  Future<bool> logOutUser() async {
    // TODO: implement logOutUser
    await auth.signOut();
    await clearDataLocally();

    return complete();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userid) async {
    // TODO: implement getUserInfo
    return await firestore.collection(usersData).document(userid).get();
  }

  @override
  Future<String> addNewProduct({Map newProduct,cat}) async {
    // TODO: implement addNewProduct
    String documentID;
    print("checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    print(cat);
    await firestore.collection(cat).add(newProduct).then((documentRef) {
      documentID = documentRef.documentID;
    });
    print("addddddddddd newwwwwwwwwwwwwww producttttttttttttttttttt");
    print(documentID);
    return documentID;

  }

  @override
   Future<List<String>> uploadProductImages({List<File> imageList,String docID, String cat}) async{
   List<String> imagesUrl = new List();
   try{
     for(int s=0;s<imageList.length;s++)
       {
         Reference storageReference = FirebaseStorage.instance
             .ref()
             .child(cat)
             .child(docID)
             .child(docID + '$s.jpg');
         UploadTask uploadTask= storageReference.putFile(imageList[s]);
         String downloadUrl = await(await uploadTask).ref.getDownloadURL();
         imagesUrl.add(downloadUrl.toString());
         print("uploadddddddddddddddddddddddddddddd complete");


       }
   }on PlatformException catch(e) {
     imagesUrl.add(error);
     print(e.details);
   }
   return imagesUrl;
  }

  @override
  Future<bool> updateProductImages({String docID, List<String> data,String cat}) async {
    // TODO: implement updateProductImages
    bool msg;
    await firestore.collection(cat).document(docID).updateData({productImages: data}).whenComplete(() {
      msg=true;
      print("updateeeeeeeeeee completeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    });
    return msg;
  }


   @override
   Future<String> addOrder({Map newOrder}) async {
     // TODO: implement addOrder
     String documentID;
     await firestore.collection(usersData).add(newOrder).then((documentRef) {
       documentID = documentRef.documentID;
     });
     print("addddddddddd newwwwwwwwwwwwwww Order");
     print(documentID);
     return documentID;

   }
}

