import 'package:flower_app/component/list.dart';
// import 'package:flower_app/pages/component/list.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<Item> selectedItems = [

  ];
  int price = 0;
  addItem(Item product) {
    price += product.price.round();
    selectedItems.add(product);
    notifyListeners();
  }
  removeItem(Item product) {
    price -= product.price.round();
    selectedItems.remove(product);
    notifyListeners();
  }
}
