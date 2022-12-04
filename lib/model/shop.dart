import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  late String id;
  late String shop_name;
  late String image_path;
  late String selfIntroduction;
  late String shop_account_id;
  late String service;
  late String address;
  late String instagram;
  late String googlemap;
  late List<dynamic>? menu_genre1;
  late List<dynamic>? menu_genre2;
  late List<dynamic>? menu_genre3;
  late int place;
  late int olive;
  late String place_string;
  int? selectedOption;
  Timestamp? createdTime;
  Timestamp? updatedTime;

  Shop(
      {this.id = '',
      this.shop_name = '',
      this.image_path = '',
      this.selfIntroduction = '',
      this.shop_account_id = '',
      this.service = '',
      this.address = '',
      this.instagram = '',
      this.googlemap = '',
      this.createdTime,
      this.updatedTime,
      this.selectedOption,
      this.place = 1,
      this.olive = 0,
      this.place_string = '高松',
      this.menu_genre1,
      this.menu_genre2,
      this.menu_genre3});
}
