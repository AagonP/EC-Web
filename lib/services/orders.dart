import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderServices {
  String collection = "receipts";


  Future<String> getStoreID() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    String store_id;
    await FirebaseFirestore.instance
        .collection('admins')
        .where('id', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {});
      for (DocumentSnapshot admin in querySnapshot.docs) {
        store_id = admin['storeId'];
        if (store_id.isNotEmpty) return store_id;
      }
    });
    return store_id;
  }

  Future<List<OrderModel>> getAllOrders() async {
    String store_id = await getStoreID();
    List<OrderModel> orders = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .where('store_id', isEqualTo: store_id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {});
      for (DocumentSnapshot order in querySnapshot.docs) {
        final amount = order.data()['amount'];
        final is_processed = order.data()['is_processed'];
        final nonce = order.data()['nonce'];
        final created_time = order.data()['created_time'].toString();
        final payment_type = order.data()['payment_type'];
        final description = order.data()['description'];
        final uid = order.data()['uid'];
        print(is_processed);
        orders.add(OrderModel(amount, is_processed, nonce, description,
            created_time, payment_type, uid));
      }
    });
    print("end get all receipts");
    return orders;
  }

  Future<List<OrderModel>> getAllOrdersByDate(String date) async {
    String store_id = await getStoreID();
    List<OrderModel> orders = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .where('store_id', isEqualTo: store_id)
        .where('created_time', isEqualTo: date)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {});
      for (DocumentSnapshot order in querySnapshot.docs) {
        final amount = order.data()['amount'];
        final is_processed = order.data()['is_processed'];
        final nonce = order.data()['nonce'];
        final created_time = order.data()['created_time'].toString();
        final payment_type = order.data()['payment_type'];
        final description = order.data()['description'];
        final uid = order.data()['uid'];
        print(is_processed);
        orders.add(OrderModel(amount, is_processed, nonce, description,
            created_time, payment_type, uid));
      }
    });
    print("end get all receipts");
    return orders;
  }
}
