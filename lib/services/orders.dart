import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';

class OrderServices {
  String collection = "stores";

  Future<List<OrderModel>> getAllOrders() async {
    print("get all orders");
    List<OrderModel> orders = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["title"]);
      });
      for (DocumentSnapshot order in querySnapshot.docs) {
        orders.add(OrderModel.fromSnapshot(order));
      }
    });
    print("end get all orders");
    return orders;
  }
}
