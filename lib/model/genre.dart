import 'package:cloud_firestore/cloud_firestore.dart';

class Genre {
  late String name;
  late String imagePath;
  Timestamp? createdTime;

  Genre({
    this.name = '1',
    this.imagePath = '1',
    this.createdTime,
  });
}
