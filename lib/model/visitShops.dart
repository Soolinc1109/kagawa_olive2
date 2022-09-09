import 'package:cloud_firestore/cloud_firestore.dart';

class VisitShop {
  String id;
  String shop_id;
  bool is_permit;
  Timestamp? visit_time;

  VisitShop({
    this.id = '',
    this.shop_id = '',
    this.is_permit = false,
    this.visit_time,
  });
}
