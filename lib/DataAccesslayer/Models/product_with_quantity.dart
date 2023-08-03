import 'product.dart';

class ProductWithQuantity {
  Product product;
  int quantity;

  ProductWithQuantity({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'quantity': quantity,
    };
  }

  factory ProductWithQuantity.fromMap(Map<String, dynamic> map) {
    return ProductWithQuantity(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}
