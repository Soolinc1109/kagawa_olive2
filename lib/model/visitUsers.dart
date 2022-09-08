import 'package:cloud_firestore/cloud_firestore.dart';

class VisitUser {
  String id;
  String user_id;
  bool is_nice;
  Timestamp? visit_time;

  VisitUser({
    this.id = '',
    this.user_id = '',
    this.is_nice = false,
    this.visit_time,
  });
}
