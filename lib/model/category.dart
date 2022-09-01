import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/shop.dart';

class Category {
  late int num;
  late String id;
  final String categoryName;
  final String image_path;

  Category(
      {this.num = 1,
      this.categoryName = 'a',
      this.image_path = 'a',
      this.id = 'a'});
}
