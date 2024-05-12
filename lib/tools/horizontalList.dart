import 'package:flutter/material.dart';
import 'package:trendy_hues/tools/dress.dart';
import 'package:trendy_hues/tools/footwear.dart';
import 'package:trendy_hues/tools/jeans.dart';
import 'package:trendy_hues/tools/pants.dart';
import 'package:trendy_hues/tools/shoes.dart';
import 'package:trendy_hues/tools/t_shirt.dart';
import 'package:trendy_hues/tools/tees.dart';
class TrendyhorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector (
            onLongPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Trendyt_shirt()));
            },
              child: Category(
                image_location: 'assets/image/tshirt.png',
                image_caption: 'shirt',
              ),
          ),


          GestureDetector(
            onLongPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyTees()));
            },
            child: Category(
              image_location: 'assets/image/tops.png',
              image_caption: 'tees',
            ),
          ),

          GestureDetector(
            onLongPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyDress()));
            },
            child: Category(
              image_location: 'assets/image/dress.png',
              image_caption: 'dress',
            ),
          ),

          GestureDetector(
            onLongPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyJeans()));
            },
            child: Category(
              image_location: 'assets/image/jeans.png',
              image_caption: 'jeans',
            ),
          ),

          GestureDetector(
            onLongPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyFootwear()));
            },
            child: Category(
              image_location: 'assets/image/footwear.png',
              image_caption: 'footwear',
            ),
          ),

          GestureDetector(
            onLongPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyPants()));
            },
            child: Category(
              image_location: 'assets/image/pants.png',
              image_caption: 'pants',
            ),
          ),

          GestureDetector(
            onLongPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyShoes()));
            },
            child: Category(
              image_location: 'assets/image/shoes.png',
              image_caption: 'shoes',
            ),
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category(
      {
        this.image_location,
        this.image_caption,
      }
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5,bottom: 10),
      child: InkWell(onTap: (){},
        child: Container(
          //margin: EdgeInsets.symmetric(vertical: 20),
            width: 100.0,
            child:ListTile(
                contentPadding: const EdgeInsets.only(right: 20,bottom: 20),
                title: Image.asset(
                  image_location,
                  width: 100.0,
                ),
                subtitle: Container(
                  alignment: Alignment.topCenter,
                  child: Text(image_caption,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
            )
        ),
      ),
    );
  }
}
