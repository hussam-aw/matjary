class ProductMovement {
  int quantity;
  String movement;
  String ware;
  String statement;

  ProductMovement({
    required this.quantity,
    required this.movement,
    required this.ware,
    required this.statement,
  });

  factory ProductMovement.fromJson(Map<String, dynamic> map) => ProductMovement(
        quantity: map["quantity"],
        movement: map["movement"],
        ware: map["ware"],
        statement: map["note"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "movement": movement,
        "ware": ware,
        "note": statement,
      };
}
