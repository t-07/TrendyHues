import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/Config/footwear.dart';
import 'package:trendy_hues/Config/jeans.dart';
import 'package:trendy_hues/Config/pants.dart';
import 'package:trendy_hues/Config/shoes.dart';
import 'package:trendy_hues/Config/t_shirt.dart';
import 'package:trendy_hues/Config/tees.dart';

class DeleteProducts extends StatefulWidget {
  @override
  _DeleteProductsState createState() => _DeleteProductsState();
}

class _DeleteProductsState extends State<DeleteProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      /*appBar: new AppBar(
        title: new Text("App Admin",style: TextStyle(
            color: Colors.blueGrey
        ),),
        backgroundColor: Colors.yellow.shade100,
        centerTitle: true,
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),*/
      //drawer: new Drawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: new Column(
          children: <Widget>[
         new SizedBox(
              height: 20.0,
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 new GestureDetector(
                    onTap: () {
                        //TrendyTees();
                     Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (context) => TrendyTees()));
                    },
                       child: new CircleAvatar(
                        maxRadius: 70.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            new Icon(Icons.person_search),
                            new SizedBox(
                              height: 10.0,
                             ),
                            new Text("tees"),
                          ],
          ),
        ),
      ),

                 new GestureDetector(
                   onTap: () {
                     //TrendyTees();
                     Navigator.of(context).push(new CupertinoPageRoute(
                         builder: (context) => Trendyt_shirt()));
                   },
                   child: new CircleAvatar(
                     maxRadius: 70.0,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         new Icon(Icons.person_search),
                         new SizedBox(
                           height: 10.0,
                         ),
                         new Text("Shirts"),
                       ],
                     ),
                   ),
                 ),


               ],
            ),

            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    //TrendyTees();
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => TrendyPants()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.emoji_people_sharp),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Pants"),
                      ],
                    ),
                  ),
                ),

                new GestureDetector(
                  onTap: () {
                    //TrendyTees();
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => TrendyShoes()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.scatter_plot_rounded),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Shoes"),
                      ],
                    ),
                  ),
                ),


              ],
            ),

            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    //TrendyTees();
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => TrendyFootwear()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.scatter_plot),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Footwear"),
                      ],
                    ),
                  ),
                ),

                new GestureDetector(
                  onTap: () {
                    //TrendyTees();
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => TrendyJeans()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.emoji_people_sharp),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Jeans"),
                      ],
                    ),
                  ),
                ),


              ],
            ),

          ],
        ),
      )
    );
  }
}
