class ProductReport {
  int id;
  String productName;
  int quantity;
  List<Map<String, int>> wares;

  ProductReport({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.wares,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': productName,
      'quantity': quantity,
      'ware': wares,
    };
  }

  factory ProductReport.fromMap(Map<String, dynamic> map) {
    return ProductReport(
      id: map['id'] as int,
      productName: map['name'],
      quantity: map['quantity'],
      wares: map['ware'],
    );
  }
}
