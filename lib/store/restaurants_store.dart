import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yemak_app/api/api.dart';
import 'package:yemak_app/models/restaurants_model.dart';

class RestaurantsStore extends ChangeNotifier {
  List restaurants = [];
  int activeId = 0;
  List restaurant = [];
  bool isLoading = false; // Yangi flag qo'shildi

  void setActiveId(int id) {
    activeId = id;
    notifyListeners();
  }

  ApiClient api = ApiClient();

  Future<void> setRestaurants() async {
    isLoading = true;
    notifyListeners();

    Response res = await api.get("/user/restaurant");
    restaurants = List<RestaurantsModel>.from(
      res.data["data"]["restaurants"].map((e) => RestaurantsModel.fromJson(e)),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> setRestaurant(id) async {
    restaurant = [];
    notifyListeners(); // UI yangilansin

    Response res = await api.get("/user/restaurant/view?id=$id");
    restaurant.add(RestaurantsModel.fromJson(res.data["data"]));

    notifyListeners();
  }

  Future<void> setCategoryRestaurant(int id) async {
    isLoading = true;
    notifyListeners();

    Response res = await api.get("/user/category/restaurant?id=$id");
    restaurants = List<RestaurantsModel>.from(
      res.data["data"]["restaurants"].map((e) => RestaurantsModel.fromJson(e)),
    );

    isLoading = false;
    notifyListeners();
  }
}
