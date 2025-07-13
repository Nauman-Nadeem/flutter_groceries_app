class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      image: json['image'],
      description: json['description'],
    );
  }
}
