class Product {
  final int id;
  final String name;
  final String specialNumber;
  final double wholesalePrice;
  final double retailPrice;
  final double supplierPrice;
  final int quantity;
  final int affectedExchange;
  final double initialPrice;
  final String category;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.name,
    required this.specialNumber,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.supplierPrice,
    required this.quantity,
    required this.affectedExchange,
    required this.initialPrice,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "special_number": specialNumber,
      "wholesale_price": wholesalePrice,
      "retail_price": retailPrice,
      "supplier_price\t": supplierPrice,
      "quantity": quantity,
      "affected_exchange": affectedExchange,
      "initial_price": initialPrice,
      "category": category,
      "images": images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      specialNumber: map['special_number'] ?? "",
      wholesalePrice: map['wholesale_price'].toDouble() ?? 0.0,
      retailPrice: map['retail_price'].toDouble() ?? 0.0,
      supplierPrice: map['supplier_price\t'].toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 0,
      affectedExchange: map['affected_exchange'] ?? 0,
      initialPrice: map['initial_price'].toDouble() ?? 0.0,
      category: map['category'] ?? "",
      images: map['images'] ?? [],
    );
  }
}