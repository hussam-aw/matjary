import 'product.dart';

class WareReport {
  int id;
  Product product;
  int quantity;

  WareReport({
    required this.id,
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }

  factory WareReport.fromMap(Map<String, dynamic> map) {
    return WareReport(
      id: map['id'] as int,
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}
