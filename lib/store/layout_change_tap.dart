import 'package:flutter/material.dart';

class LayoutChangeTap extends ChangeNotifier {
  int tap = 0;

  void changeTap(int index) {
    tap = index;
    notifyListeners();
  }
}
