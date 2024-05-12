//Databases
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/db/category.dart';

const String usersData = "usersData";
const String appProducts = "appProducts";
const String shirts = "shirts";
const String tees = "tees";
const String dress = "dress";
const String jeans = "jeans";
const String footwear = "footwear";
const String pants = "pants";
const String shoes = "shoes";
//Database Collections
const String userCollection = "userCollection";


//user details
const String userID = "userID";
const String acctFullName = "acctFullName";
const String phoneNumber = "phoneNumber";
const String address = "address";
const String city = "city";
const String pin = "pin";
const String state = "state";
const String userEmail = "userEmail";
const String userPassword = "userPassword";
const String photoURL = "photoURL";
const String loggedIN = "loggedIN";

//product details
const String productTitle="productTitle";
const String productPrice="productPrice";
const String productDesc="productDesc";
const String productCat="productCat";
const String productColor="productColor";
const String productSize="productSize";
const String productQty="productQty";
const String date="date";
const String productImages="productImages";

//app data
const String successful = "successful";
const String error = "error";

/*List<DocumentSnapshot> categories = <DocumentSnapshot>[];
List<DropdownMenuItem<String>> categoriesDropDown =
<DropdownMenuItem<String>>[];

@override
void initState() {
  getCategories();
  getBrands();
}*/

List<String> localColors = [
  "Select a color",
  "All Colors",
  "Red",
  "Orange",
  "Yellow",
  "Green",
  "Blue",
  "Indigo",
  "Violet"
];

List<String> localSizes = [
  "Select a size",
  "All Sizes",
  "Small",
  "Medium",
  "Large",
  "Extra Large"
];


/*
List<DropdownMenuItem<String>> getCategoriesDropdown() {
  List<DropdownMenuItem<String>> items = new List();
  for (int i = 0; i < categories.length; i++) {
    setState(() {
       items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
    });
  }
  return items;
}*/


List<String> localCatgeories = [
  "Select Product category",
  "appProducts",
  "shirts",
  "tees",
  "dress",
  "jeans",
  "footwear",
  "pants",
  "shoes",
];