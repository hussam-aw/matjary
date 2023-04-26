class Order {
  final int id;
  final int total;
  final int userId;
  final int customerId;
  final String notes;
  final String type;
  final int paidUp;
  final int restOfTheBill;
  final int wareId;
  final int toWareId;
  final int bankId;
  final int sellType;
  final int status;
  final double? expenses;
  final double? discount;
  Order(
      {required this.id,
      required this.total,
      required this.userId,
      required this.customerId,
      required this.notes,
      required this.type,
      required this.paidUp,
      required this.restOfTheBill,
      required this.wareId,
      required this.toWareId,
      required this.bankId,
      required this.sellType,
      required this.status,
      required this.expenses,
      required this.discount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "total": total,
      "user_id": userId,
      "customer_id": customerId,
      "notes": notes,
      "type": type,
      "paid_up": paidUp,
      "rest_of_the_bill": restOfTheBill,
      "ware_id": wareId,
      "to_ware_id": toWareId,
      "bank_id": bankId,
      "sell_type": sellType,
      "status": status,
      "expenses": expenses,
      "discount": discount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      total: map['total'] as int,
      userId: map['user_id'] as int,
      customerId: map['customer_id'] as int,
      notes: map['notes'] as String,
      type: map['type'] as String,
      paidUp: map['paid_up'] as int,
      restOfTheBill: map['rest_of_the_bill'] as int,
      wareId: map['ware_id'] as int,
      toWareId: map['to_ware_id'] as int,
      bankId: map['bank_id'] as int,
      sellType: map['sell_type'] as int,
      status: map['status'] as int,
      expenses: map['expenses'] ?? 0.0,
      discount: map['discount'] ?? 0.0,
    );
  }
}
