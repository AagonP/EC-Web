import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  static const ID = "id";
  static const CATEGORIES = "categories";
  static const DESCRIPTION = "description";
  static const IMAGEURL = "imageURL";
  static const PRICE = "price";
  static const TITLE = "title";
  static const STOREID = "store_id";

  String _id;
  List<dynamic> _categories;
  String _description;
  String _imageUrl;
  double _price;
  String _title;
  String _storeId;

  String get id => _id;

  List<dynamic> get categories => _categories;

  String get description => _description;

  String get imageUrl => _imageUrl;

  double get price => _price;

  String get title => _title;

  String get storeId => _storeId;

  FoodModel(
      {String id,
      List<dynamic> categories,
      String description,
      String imageUrl,
      double price,
      String title,
      String storeId})
      : _id = id,
        _categories = categories,
        _description = description,
        _imageUrl = imageUrl,
        _price = price,
        _title = title,
        _storeId= storeId;

  FoodModel.fromSnapshot(DocumentSnapshot snapshot) {
    // _brand = snapshot.data()[BRAND];
    _id = snapshot.id;
    _categories = snapshot.data()[CATEGORIES];
    _description = snapshot.data()[DESCRIPTION];
    _imageUrl = snapshot.data()[IMAGEURL];
    _price = snapshot.data()[PRICE];
    _title = snapshot.data()[TITLE];
    _storeId = snapshot.data()[STOREID];
  }

  Map<String, Object> toJson() {
    return {
      'categories': _categories,
      'description': _description,
      'imageURL': _imageUrl,
      'price': _price,
      'title': _title,
      'store_id': _storeId,
    };
  }
}
