import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/adminScreens/add_products.dart';
import 'package:trendy_hues/adminScreens/deleteProducts.dart';
class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Products"),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add),text: "Add Products"),
                Tab(icon: Icon(Icons.delete),text: "Delete Products"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AddProducts(),
              DeleteProducts(),

            ],
          ),
        ),
      )
    );
  }
}
