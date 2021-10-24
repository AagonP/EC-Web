import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  static const ID = "id";
  // static const BRAND = "brand";
  static const ADDRESS = 'address';
  static const DISTANCE = 'distance';
  static const TITLE = 'title';
  static const RATING = 'rating';

  String _id;
  String _brand;
  String _address, _title;
  double _distance, _rating;

//  getters
  String get brand => _brand;
  String get id => _id;
  String get address => _address;
  String get title => _title;
  double get distance => _distance;
  double get rating => _rating;

  BrandModel({String address, String title, double distance, double rating})
      : _address = address,
        _title = title,
        _distance = distance,
        _rating = rating;

  BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    // _brand = snapshot.data()[BRAND];
    _id = snapshot.id;
    _address = snapshot.data()[ADDRESS];
    _title = snapshot.data()[TITLE];
    _distance = snapshot.data()[DISTANCE];
    _rating = snapshot.data()[RATING];
  }

  Map<String, Object> toJson() {
    return {
      'address': _address,
      'title': _title,
      'distance': _distance,
      'rating': _rating,
    };
  }


}
