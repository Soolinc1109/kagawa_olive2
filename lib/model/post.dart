import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String id;
  late String content;
  late String postAccountId;
  Timestamp? createdTime;

  Post({
    this.id = '1',
    this.content = '1',
    this.postAccountId = '1',
    this.createdTime,
  });
}
