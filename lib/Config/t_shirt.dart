//import 'dart:html';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'dart:typed_data';
import 'package:trendy_hues/tools/app_data.dart';

import 'package:trendy_hues/services/DataHolder.dart';

import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';
import 'package:trendy_hues/tools/Store.dart';
/*
class Trendyt_shirt extends StatelessWidget {
  Widget makeImagesGrid() {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context,index) {
        return ImageGridItem(index+1);
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(""),
      ),
      body: Container(
        child: makeImagesGrid(),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  int _index;
  ImageGridItem(int index){
    this._index=index;
  }
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}
class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile;
  var photosReference = FirebaseStorage.instance.ref().child("shirts");
  getImage() {
   if(!requestedIndexes.contains(widget._index)) {
     int MAX_SIZE = 7*1024*1024;
     photosReference.child("shirt_${widget._index}.jpg").getData(MAX_SIZE).then((data){
       this.setState(() {
         imageFile =data;
       });
       imageData.putIfAbsent(widget._index, (){
         return data;
       });
     });onError:((error){
       debugPrint(error.toString());
     });
     requestedIndexes.add(widget._index);
     print(widget._index);
   }
  }

  Widget decideGridTileWidget() {
    if(imageFile==null)
      {
        return Center(child: Text("No Data"));
      }else
        {
          return Image.memory(imageFile,fit:BoxFit.cover,);
        }
  }
  @override
  void initState() {
    super.initState();
    if(!imageData.containsKey(widget._index)){
    getImage();
    }
    else{
      this.setState(() {
        imageFile=imageData[widget._index];
      });
  }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridTile(child: decideGridTileWidget());
  }
}*/

class Trendyt_shirt extends StatefulWidget {
  @override
  _Trendyt_shirtState createState() => _Trendyt_shirtState();
}

class _Trendyt_shirtState extends State<Trendyt_shirt> {
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
  FirebaseFirestore firestore=Firestore.instance;
  @override
  Widget build(BuildContext context) {
    this.context=context;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection(shirts).snapshots(),
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
            ),]
          ),
        ),
      );
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
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Firestore.instance.collection('shirts').doc('JfcjJlpjPO6GBwtC8TfZ').delete();
                      FirebaseStorage.instance.refFromURL('gs://ecommerce-4b036.appspot.com/shirts/JfcjJlpjPO6GBwtC8TfZ').delete();
                    })
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

}


