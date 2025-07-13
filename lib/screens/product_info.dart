import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/product.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int quantity = 1;
  bool loading = true;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _loadQuantity();
  }

  Future<void> _loadQuantity() async {
    final cart = await _cartService.loadCart([widget.product]);
    setState(() {
      quantity = cart[widget.product.id] ?? 1;
      loading = false;
    });
  }

  Future<void> _updateCart(int qty) async {
    await _cartService.updateQuantity(widget.product.id, qty);
    setState(() {
      quantity = qty > 0 ? qty : 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          qty > 0
              ? '${widget.product.name} added to cart (x$qty)'
              : '${widget.product.name} removed from cart',
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // Product Name and Favorite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Name & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "1kg, Price",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Quantity Selector & Price
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: quantity > 1
                            ? () => setState(() => quantity--)
                            : null,
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Rs ${(product.price * quantity).toStringAsFixed(1)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

            const Divider(height: 32, thickness: 1),

            //  Product Detail
            ExpansionTile(
              title: const Text(
                "Product Detail",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Text(
                  product.description ?? "No description available.",
                  style: TextStyle(color: Colors.grey[800], fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //  Nutritions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nutritions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("100gr", style: TextStyle(fontSize: 13)),
                ),
              ],
            ),

            const SizedBox(height: 8),

            //  Review
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Review",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: List.generate(
                    5,
                    (_) =>
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Add to Cart
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _updateCart(quantity),
                child: const Text(
                  "Add To Basket",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
