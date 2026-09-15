import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Product>> getProducts() async {
    final response = await dio.get('https://dummyjson.com/products');

    List products = response.data['products'];

    return products.map((item) {
      return Product.fromJson(item);
    }).toList();
  }
}