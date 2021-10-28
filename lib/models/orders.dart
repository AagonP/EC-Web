import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String amount;
  final bool is_processed;
  final String nonce;
  final String description;
  final String created_time;
  final String payment_time;
  OrderModel(this.amount, this.is_processed, this.nonce, this.description,
      this.created_time, this.payment_time);
}
