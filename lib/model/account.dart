import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  late String id;
  late String name;
  late String imagePath;
  late String selfIntroduction;
  late String userId;
  late String universal;
  late String highschool;
  late String junior_high_school;
  late String sanukiben;
  late String kagawareki;
  late String zokusei;
  late String likemovie;
  late String likefood;
  late String hobby;

  Timestamp? createdTime;
  Timestamp? updatedTime;

  Account({
    this.id = '',
    this.name = '',
    this.imagePath = '',
    this.selfIntroduction = '',
    this.userId = '',
    this.universal = '',
    this.highschool = '',
    this.junior_high_school = '',
    this.sanukiben = '',
    this.kagawareki = '',
    this.zokusei = '',
    this.likemovie = '',
    this.likefood = '',
    this.hobby = '',
    this.createdTime,
    this.updatedTime,
  });
}
