class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imagePath: map['imagePath'],
      isFavorite: map['isFavorite'],
    );
  }
}
