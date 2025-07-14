import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

// CartScreen widget that displays the user's shopping cart
// It allows users to view products in their cart, update quantities, and proceed to checkout
class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> allProducts = [];
  Map<String, int> cart = {};
  bool loading = true;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    allProducts = await _cartService.loadProducts();
    cart = await _cartService.loadCart(allProducts);
    setState(() => loading = false);
  }

  Future<void> _updateQuantity(String productId, int qty) async {
    await _cartService.updateQuantity(productId, qty);
    if (qty > 0) {
      cart[productId] = qty;
    } else {
      cart.remove(productId);
    }
    setState(() {});
  }

  double get totalPrice {
    double total = 0;
    for (var entry in cart.entries) {
      final product = allProducts.firstWhere(
        (p) => p.id == entry.key,
        orElse: () => allProducts[0],
      );
      total += product.price * entry.value;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Center(child: CircularProgressIndicator());
    if (cart.isEmpty) {
      return Center(child: Text('Your cart is empty'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: cart.length,
              separatorBuilder: (_, __) => Divider(height: 32, thickness: 1),
              itemBuilder: (context, idx) {
                final productId = cart.keys.elementAt(idx);
                final qty = cart[productId]!;
                final product = allProducts.firstWhere(
                  (p) => p.id == productId,
                  orElse: () => allProducts[0],
                );
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        product.image,
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 12),
                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "1kg, Price",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Quantity Controls
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: qty > 1
                              ? () => _updateQuantity(productId, qty - 1)
                              : null,
                        ),
                        Text('$qty', style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () => _updateQuantity(productId, qty + 1),
                        ),
                      ],
                    ),
                    // Price
                    SizedBox(width: 8),
                    Text(
                      'Rs${(product.price * qty).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Remove Button
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () => _updateQuantity(productId, 0),
                    ),
                  ],
                );
              },
            ),
          ),
          // Checkout Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Go to Checkout   Rs${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
