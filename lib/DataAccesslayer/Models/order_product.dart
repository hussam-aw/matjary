class OrderProduct {
  int? id;
  int productId;
  int quantity;
  num price;
  num? totalPrice;
  int? orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderProduct({
    this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    this.totalPrice,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderProduct.fromDatabaseJson(Map<String, dynamic> json) =>
      OrderProduct(
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
      );

  factory OrderProduct.fromApiJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["total_price"],
        orderId: json["order_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "price": price,
      };
}
