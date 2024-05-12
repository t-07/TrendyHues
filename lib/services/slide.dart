import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/image/4.png',
    title: 'About Us',
    description: 'Founded in 2010 and based in India,TrendyHues is a trusted community marketPlace for people to list,discover and order unique brands-online.',
  ),
  Slide(
    imageUrl: 'assets/image/e5.png',
    title: 'A Cool Way to Get Start',
    description: 'Rising Above the Obstacles and pushing to the mountainTop is the thrust of the brand.TrendyHues is inspired by the Higher,Faster,Stronger demand of online shopping.',
  ),
  Slide(
    imageUrl: 'assets/image/3.png',
    title: 'It\'s Just the Beginning',
    description: 'A great place for anyone who loves colorful and wonderful closet. We provide clothing and shoes for both men and women.Our Products are carefully chosen because we believe everyone needs high quality products for their daily life.(0181-2234568)',
  ),
];