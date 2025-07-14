import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

// Product Service
// This service handles product-related operations like loading products from JSON
class ProductService {
  Future<List<Product>> loadProducts() async {
    final String data = await rootBundle.loadString('lib/assets/product.json');
    final List<dynamic> jsonResult = jsonDecode(data);
    return jsonResult.map((item) => Product.fromJson(item)).toList();
  }
}
