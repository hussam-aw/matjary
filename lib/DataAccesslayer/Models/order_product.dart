class OrderProduct {
  int id;
  int productId;
  int quantity;
  num price;
  num totalPrice;
  int orderId;
  DateTime createdAt;
  DateTime updatedAt;

  OrderProduct({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
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
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "order_id": orderId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
