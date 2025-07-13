import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().loadProducts();
  }

  Widget _buildCategorySection(String category, List<Product> products) {
    if (products.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              TextButton(
                onPressed: () {
                  // empty for now
                },
                child: Text('See all', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),

        // Horizontal product list
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => SizedBox(width: 10),
            itemBuilder: (context, index) => SizedBox(
              width: 180,
              child: ProductCard(product: products[index]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GroceryMart"), centerTitle: true),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allProducts = snapshot.data!;
            final filteredProducts = allProducts
                .where(
                  (product) => product.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
                )
                .toList();

            return ListView(
              padding: EdgeInsets.all(10),
              children: [
                //  Search Bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                //  Vegetables
                _buildCategorySection(
                  'Vegetables',
                  filteredProducts
                      .where((product) => product.category == 'Vegetables')
                      .toList(),
                ),

                SizedBox(height: 16),

                //  Meat
                _buildCategorySection(
                  'Meat',
                  filteredProducts
                      .where((product) => product.category == 'Meat')
                      .toList(),
                ),

                SizedBox(height: 16),

                //  Fruits
                _buildCategorySection(
                  'Fruits',
                  filteredProducts
                      .where((product) => product.category == 'Fruits')
                      .toList(),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
