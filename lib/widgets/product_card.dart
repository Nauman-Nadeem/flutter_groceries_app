import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../screens/product_info.dart';

// Shared cart logic helper
Future<int> getCartQuantity(Product product) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('cart_${product.id}') ?? 0;
}

Future<void> setCartQuantity(Product product, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  if (qty > 0) {
    await prefs.setInt('cart_${product.id}', qty);
  } else {
    await prefs.remove('cart_${product.id}');
  }
}

void showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ),
  );
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductInfo(product: product)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade600, width: 0.4),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    product.image,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "1kg, Price",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  AddToCartButton(product: product),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add to Cart Button 
class AddToCartButton extends StatelessWidget {
  final Product product;
  const AddToCartButton({super.key, required this.product});

  Future<void> _addToCart(BuildContext context) async {
    final currentQty = await getCartQuantity(product);
    await setCartQuantity(product, currentQty + 1);
    showSnack(context, '${product.name} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _addToCart(context),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

// Cart Action Row
class CartActionRow extends StatefulWidget {
  final Product product;
  const CartActionRow({super.key, required this.product});

  @override
  State<CartActionRow> createState() => _CartActionRowState();
}

class _CartActionRowState extends State<CartActionRow> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _loadQuantity();
  }

  Future<void> _loadQuantity() async {
    quantity = await getCartQuantity(widget.product);
    setState(() {});
  }

  Future<void> _updateQuantity(int newQty) async {
    await setCartQuantity(widget.product, newQty);
    setState(() => quantity = newQty);
  }

  void _increase() => _updateQuantity(quantity + 1);
  void _decrease() {
    if (quantity > 0) _updateQuantity(quantity - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: quantity > 0 ? _decrease : null,
        ),
        Text('$quantity', style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.green),
          onPressed: _increase,
        ),
      ],
    );
  }
}
