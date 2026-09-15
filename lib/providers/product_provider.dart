import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<String> categories = ['All'];

  String selectedCategory = 'All';
  String searchQuery = '';

  bool loading = false;

  Future<void> getProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await apiService.getProducts();

      categories = ['All'];

      for (Product product in products) {
        if (!categories.contains(product.category)) {
          categories.add(product.category);
        }
      }

      applyFilters();
    } catch (e) {
      products = [];
      filteredProducts = [];
    }

    loading = false;
    notifyListeners();
  }

  void searchProducts(String value) {
    searchQuery = value;
    applyFilters();
    notifyListeners();
  }

  void filterByCategory(String category) {
    selectedCategory = category;
    applyFilters();
    notifyListeners();
  }

  void applyFilters() {
    filteredProducts = [];

    for (Product product in products) {
      bool categoryMatch = true;
      bool searchMatch = true;

      if (selectedCategory != 'All') {
        categoryMatch =
            product.category == selectedCategory;
      }

      if (searchQuery.isNotEmpty) {
        searchMatch = product.title
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }

      if (categoryMatch && searchMatch) {
        filteredProducts.add(product);
      }
    }
  }
}