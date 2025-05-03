import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yemak_app/api/api.dart';
import 'package:yemak_app/models/products_model.dart';
import 'package:yemak_app/models/restaurants_model.dart';

class SearchStore extends ChangeNotifier {
  List restaurants = [];
  List products = [];
  bool isLoading = false;

  ApiClient apiClient = ApiClient();

  Future<void> setRestaurants(String search) async {
    isLoading = true;
    Response res = await apiClient.get("/user/search?q=$search");
    restaurants = List.from(
      res.data["data"]["restaurants"].map((e) => RestaurantsModel.fromJson(e)),
    );
    products = List.from(
      res.data["data"]["products"].map((e) => ProductModel.fromJson(e)),
    );
    isLoading = false;

    notifyListeners();
  }
}
