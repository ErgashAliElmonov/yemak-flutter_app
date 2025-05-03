import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yemak_app/api/api.dart';
import 'package:yemak_app/utils/functions.dart';

class AuthStore extends ChangeNotifier {
  bool isNum = false;

  void setIsNum() {
    isNum = !isNum;
    notifyListeners();
  }

  ApiClient api = ApiClient();

  void getPhoneNumber(String phone) async {
    Response res = await api.get("/user/auth?phone_number=$phone");
    String token = res.data["data"]["access_token"];
    Storage().set("token", token);
    print(token);
    isNum = true;
    notifyListeners();
  }

  void getCode(String code, BuildContext context) async {
    Response res = await api.get("/user/auth/verify?code=$code");
    String userData = res.data["data"];
    Storage().set("user_data", userData);
    // ignore: use_build_context_synchronously
    context.go("/");
    notifyListeners();
  }
}
