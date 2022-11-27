import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/foods.dart';
import 'package:firebase_auth/firebase_auth.dart';

User user = FirebaseAuth.instance.currentUser;

class FoodsServices {
  String collection = "foods";
  String ownerId = user.uid;

  Future<List<FoodModel>> getAll() async {
    print("get all foods");
    String storeId = await getStoreID();
    List<FoodModel> foods = [];
    await firebaseFiretore
        .collection(collection)
        .where('store_id', isEqualTo: storeId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((food) {
        print(food["title"]);
        foods.add(FoodModel.fromSnapshot(food));
      });
    });
    return foods;
  }

  Future<String> getStoreID() async {
    String id = '';
    await firebaseFiretore
        .collection('admins')
        .doc(ownerId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        id = documentSnapshot['storeId'];
      }
    });
    return id;
  }

  Future<void> addFood(FoodModel foodModel) async {
    await firebaseFiretore
        .collection(collection)
        .add(foodModel.toJson())
        .then((value) => print("Food Added"))
        .catchError((error) => print("Failed to add food: $error"));
  }

  Future<void> deleteFood(String id) async {
    await firebaseFiretore
        .collection(collection)
        .doc(id)
        .delete()
        .then((value) => print("Food Deleted"))
        .catchError((error) => print("Failed to delete food: $error"));
  }

  Future<void> updateFood(String id, FoodModel foodModel) async {
    await firebaseFiretore
        .collection(collection)
        .doc(id)
        .update(foodModel.toJson())
        .then((value) => print("Food Updated"))
        .catchError((error) => print("Failed to update food: $error"));
  }
}
