import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> items = [];
  final Map<int, int> quantities = {};

  void addToCart(Product product) {
    if (!items.any((item) => item.id == product.id)) {
      items.add(product);
      quantities[product.id] = 1;
    } else {
      quantities[product.id] = quantities[product.id]! + 1;
    }

    notifyListeners();
  }

  void increase(Product product) {
    quantities[product.id] = quantities[product.id]! + 1;
    notifyListeners();
  }

  void decrease(Product product) {
    if (quantities[product.id]! > 1) {
      quantities[product.id] = quantities[product.id]! - 1;
    } else {
      remove(product);
    }

    notifyListeners();
  }

  void remove(Product product) {
    items.removeWhere((item) => item.id == product.id);
    quantities.remove(product.id);
    notifyListeners();
  }

  int getQuantity(Product product) {
    return quantities[product.id] ?? 0;
  }

  double get total {
    double amount = 0;

    for (Product product in items) {
      amount += product.price * getQuantity(product);
    }

    return amount;
  }
}