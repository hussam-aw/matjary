class ProductWithQuantity {
  int productId;
  int quantity;

  ProductWithQuantity({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': productId,
      'quantity': quantity,
    };
  }

  factory ProductWithQuantity.fromMap(Map<String, dynamic> map) {
    return ProductWithQuantity(
      productId: map['id'] as int,
      quantity: map['quantity'],
    );
  }
}
