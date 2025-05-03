import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/api/api.dart';
import 'package:yemak_app/models/category_model.dart';
import 'package:yemak_app/store/restaurants_store.dart';

class CategoryStore with ChangeNotifier {
  List category = [];
  int activeId = 0;

  ApiClient api = ApiClient();

  void addCategory() async {
    Response res = await api.get("/user/category");

    category = [
      CategoryModel(id: 0, title: "Barchasi"),
      ...res.data["data"].map((e) => CategoryModel.fromJson(e)).toList(),
    ];
    notifyListeners();
  }

  void setActiveId(int categoryId, BuildContext context) {
    activeId = categoryId;
    notifyListeners();

    if (activeId != 0) {
      context.read<RestaurantsStore>().setCategoryRestaurant(categoryId);
    } else {
      context.read<RestaurantsStore>().setRestaurants();
    }
  }
}
