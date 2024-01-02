import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get items {
    return {..._item};
  }

  int get itemsCount {
    return _item.length;
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }

  void addItem(Product product) {
    if (_item.containsKey(product.id)) {
      _item.update(
        product.id,
        (existingItem) => CartItem(
            id: existingItem.id,
            productID: existingItem.productID,
            name: existingItem.name,
            quantity: existingItem.quantity + 1,
            price: existingItem.price),
      );
    } else {
      _item.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productID: product.id,
            name: product.name,
            quantity: 1,
            price: product.price),
      );
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;

    _item.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }
}
