import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/brands.dart';

class BrandsServices {
  String collection = "stores";

  Future<List<BrandModel>> getAll() async {
    print("get all stores");
    List<BrandModel> brands = [];
    await firebaseFiretore
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["title"]);
      });
      for (DocumentSnapshot brand in querySnapshot.docs) {
        brands.add(BrandModel.fromSnapshot(brand));
      }
    });
    return brands;
  }

  Future<void> addStore(BrandModel brandModel) async {
    await firebaseFiretore
        .collection(collection)
        .add(brandModel.toJson())
        .then((value) => print("Store Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteStore(String id) async {
    await firebaseFiretore
        .collection(collection)
        .doc(id)
        .delete()
        .then((value) => print("Store Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateStore(String id, BrandModel brandModel) async {
    await firebaseFiretore
        .collection(collection)
        .doc(id)
        .update(brandModel.toJson())
        .then((value) => print("Store Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
