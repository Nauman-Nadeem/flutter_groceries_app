import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// Cart Service
// This service handles cart operations like loading products and updating quantities
class CartService {
  Future<List<Product>> loadProducts() async {
    final jsonStr = await rootBundle.loadString('lib/assets/product.json');
    final List<dynamic> jsonList = json.decode(jsonStr);
    return jsonList.map((e) => Product.fromJson(e)).toList();
  }

  Future<Map<String, int>> loadCart(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = <String, int>{};
    for (var p in products) {
      final qty = prefs.getInt('cart_${p.id}') ?? 0;
      if (qty > 0) cart[p.id] = qty;
    }
    return cart;
  }

  Future<void> updateQuantity(String productId, int qty) async {
    final prefs = await SharedPreferences.getInstance();
    if (qty > 0) {
      await prefs.setInt('cart_$productId', qty);
    } else {
      await prefs.remove('cart_$productId');
    }
  }
}
