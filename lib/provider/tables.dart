import 'dart:math';

import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/models/categories.dart';
import 'package:ecommerce_admin_tut/models/foods.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/services/brands.dart';
import 'package:ecommerce_admin_tut/services/categories.dart';
import 'package:ecommerce_admin_tut/services/foods.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:ecommerce_admin_tut/services/products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_table/DatatableHeader.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers

  List<DatatableHeader> foodsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Categories",
        value: "categories",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Description",
        value: "description",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Image URL",
        value: "imageURL",
        flex: 2,
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Title",
        value: "title",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Store Id",
        value: "store_id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> ordersTableHeader = [
    DatatableHeader(
        text: "Nonce",
        value: "nonce",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Description",
        value: "description",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Payment type",
        value: "payment_type",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Created time",
        value: "created_time",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Is processed",
        value: "is_processed",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Amount",
        value: "amount",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
  ];

  List<DatatableHeader> productsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Brand",
        value: "brand",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sizes",
        value: "sizes",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Colors",
        value: "colors",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Featured",
        value: "featured",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sale",
        value: "sale",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> brandsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Address",
        value: "address",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Title",
        value: "title",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Distance",
        value: "distance",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Rating",
        value: "rating",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> categoriesTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> foodsTableSource = [];
  List<Map<String, dynamic>> ordersTableSource = [];
  List<Map<String, dynamic>> productsTableSource = [];
  List<Map<String, dynamic>> categoriesTableSource = [];
  List<Map<String, dynamic>> brandsTableSource = [];

  List<Map<String, dynamic>> selecteds = [];
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  FoodsServices _foodServices = FoodsServices();
  List<FoodModel> _foods = <FoodModel>[];
  // List<UserModel> get users => _foods;

  OrderServices _orderServices = OrderServices();
  List<OrderModel> _orders = <OrderModel>[];
  List<OrderModel> get orders => _orders;

  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  CategoriesServices _categoriesServices = CategoriesServices();
  List<CategoriesModel> _categories = <CategoriesModel>[];

  BrandsServices _brandsServices = BrandsServices();
  List<BrandModel> _brands = <BrandModel>[];
  String _storeId = '';
  String get storeId => _storeId;
  Future refreshReceipts() async {
    _orders = await _orderServices.getAllOrders();
    ordersTableSource.clear();
    ordersTableSource.addAll(_getOrdersData());
    notifyListeners();
  }

  Future getSearchResultByDate(String date) async {
    _orders = await _orderServices.getAllOrdersByDate(date);
    ordersTableSource.clear();
    ordersTableSource.addAll(_getOrdersData());
    notifyListeners();
  }

  Future _loadFromFirebase() async {
    _foods = await _foodServices.getAll();
    getStoreId();
    // _users = await _userServices.getAllUsers();
    _orders = await _orderServices.getAllOrders();
    // _products = await _productsServices.getAllProducts();
    // _brands = await _brandsServices.getAll();
    // _categories = await _categoriesServices.getAll();
  }

  void addStoreData(BrandModel brandModel) async {
    /// add store to database
    await _brandsServices.addStore(brandModel);
    _brands.clear();
    brandsTableSource.clear();
    notifyListeners();
    await _loadFromFirebase();
    brandsTableSource.addAll(_getBrandsData());
    notifyListeners();
  }

  void deleteStoreData(List<Map<String, dynamic>> map) async {
    /// Delete selected store items
    _brands.clear();
    brandsTableSource.clear();
    notifyListeners();
    map.forEach((Map<String, dynamic> e) async {
      await _brandsServices.deleteStore(e['id']);
    });
    await _loadFromFirebase();
    brandsTableSource.addAll(_getBrandsData());
    notifyListeners();
  }

  void updateStoreDate(String id, BrandModel brandModel) async {
    /// Update selected item
    _brands.clear();
    brandsTableSource.clear();
    notifyListeners();
    await _brandsServices.updateStore(id, brandModel);
    await _loadFromFirebase();
    brandsTableSource.addAll(_getBrandsData());
    notifyListeners();
  }

  // End Example

  // Food helper function
  void addFoodData(FoodModel foodModel) async {
    /// add store to database
    await _foodServices.addFood(foodModel);
    _foods.clear();
    foodsTableSource.clear();
    notifyListeners();
    _foods = await _foodServices.getAll();
    // await _loadFromFirebase();
    foodsTableSource.addAll(_getFoodsData());
    notifyListeners();
  }

  void deleteFoodData(List<Map<String, dynamic>> map) async {
    /// Delete selected store items
    _foods.clear();
    foodsTableSource.clear();
    notifyListeners();
    map.forEach((Map<String, dynamic> e) async {
      await _foodServices.deleteFood(e['id']);
    });
    _foods = await _foodServices.getAll();
    // await _loadFromFirebase();
    foodsTableSource.addAll(_getFoodsData());
    notifyListeners();
  }

  void updateFoodData(String id, FoodModel foodModel) async {
    /// Update selected item
    _foods.clear();
    foodsTableSource.clear();
    notifyListeners();
    await _foodServices.updateFood(id, foodModel);
    _foods = await _foodServices.getAll();
    // await _loadFromFirebase();
    foodsTableSource.addAll(_getFoodsData());
    notifyListeners();
  }

  void getStoreId() async {
    String tem = await _foodServices.getStoreID();
    _storeId = tem;
    notifyListeners();
  }

  // End Food Helper function

  // TODO: add function here to manipulate table

  List<Map<String, dynamic>> _getFoodsData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = [];
    var i = _foods.length;
    print(i);
    for (FoodModel foodData in _foods) {
      temps.add({
        "id": foodData.id,
        'categories': foodData.categories,
        'description': foodData.description,
        'imageURL': foodData.imageUrl,
        'price': foodData.price,
        'title': foodData.title,
        'store_id': foodData.storeId,
      });
      i++;
    }
    isLoading = false;
    notifyListeners();
    return temps;
  }

  List<Map<String, dynamic>> _getBrandsData() {
    List<Map<String, dynamic>> temps = [];
    for (BrandModel brand in _brands) {
      temps.add({
        "id": brand.id,
        "address": brand.address,
        "title": brand.title,
        "distance": brand.distance,
        "rating": brand.rating
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getCategoriesData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();

    for (CategoriesModel category in _categories) {
      temps.add({
        "id": category.id,
        "category": category.category,
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (OrderModel order in _orders) {
      temps.add({
        "nonce": order.nonce,
        "amount": order.amount,
        "description": order.description,
        "is_processed": order.is_processed,
        "created_time": order.created_time,
        "payment_type": order.payment_time,
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (ProductModel product in _products) {
      temps.add({
        "id": product.id,
        "name": product.name,
        "brand": product.brand,
        "category": product.category,
        "quantity": product.quantity,
        "sale": product.sale,
        "featured": product.featured,
        "colors": product.colors,
        "sizes": product.sizes,
        "price": "\$${product.price}",
      });
    }
    return temps;
  }

  initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    foodsTableSource.addAll(_getFoodsData());
    ordersTableSource.addAll(_getOrdersData());
    productsTableSource.addAll(_getProductsData());
    categoriesTableSource.addAll(_getCategoriesData());
    brandsTableSource.addAll(_getBrandsData());

    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      foodsTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      foodsTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      selecteds = foodsTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    currentPage = currentPage >= 2 ? currentPage - 1 : 1;
    notifyListeners();
  }

  next() {
    currentPage++;
    notifyListeners();
  }

  TablesProvider() {
    initData();
  }
}
