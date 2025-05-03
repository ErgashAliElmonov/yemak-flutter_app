import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yemak_app/api/api.dart';
import 'package:yemak_app/models/products_model.dart';

class ProductStore extends ChangeNotifier {
  List products = [];
  int count = 1;
  double price = 0;
  double oldPrice = 0;

  ApiClient api = ApiClient();

  void setProducts(id) async {
    products = [];
    Response res = await api.get("/user/restaurant/product?id=$id");
    products = ProductsModel.fromJson(res.data["data"]).products;
    notifyListeners();
  }

  void setCount(int index) {
    if (index.isNegative == false && index != 0) {
      count = index;
      price = oldPrice * count;
    }
    notifyListeners();
  }

  void setPrice(double index) {
    oldPrice = index;
    price = index;

    notifyListeners();
  }
}
