class Product {
  final int id;
  final String name;
  final String wholesalePrice;
  final String retailPrice;
  final String supplierPrice;
  final String quantity;
  final String affectedExchange;
  final String initialPrice;
  final int? categoryId;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.supplierPrice,
    required this.quantity,
    required this.affectedExchange,
    required this.initialPrice,
    required this.categoryId,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "wholesale_price": wholesalePrice,
      "retail_price": retailPrice,
      "supplier_price\t": supplierPrice,
      "quantity": quantity,
      "affected_exchange": affectedExchange,
      "initial_price": initialPrice,
      "category": categoryId,
      "images": images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      wholesalePrice: map['wholesale_price'].toString(),
      retailPrice: map['retail_price'].toString(),
      supplierPrice: map['supplier_price\t'].toString(),
      quantity: map['quantity'].toString(),
      affectedExchange: map['affected_exchange'].toString(),
      initialPrice: map['initial_price'].toString(),
      categoryId: map['category'],
      images: getImages(map['images'] ?? []),
    );
  }

  static List<String> getImages(images) {
    List<String> result = [];
    if (images != "[]") {
      for (int i = 0; i < images.length; i++) {
        result.add(images[i].toString());
      }
      return result;
    }
    return [];
  }
}
