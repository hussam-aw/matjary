class Order {
  final int id;
  final num total;
  final int userId;
  final int customerId;
  final String notes;
  final String type;
  final int paidUp;
  final num restOfTheBill;
  final int wareId;
  final num toWareId;
  final int bankId;
  final String sellType;
  final int status;
  final num? expenses;
  final num? discount;
  final String discountType;
  final int marketerId;
  final String marketerFeeType;
  List<Map<String, dynamic>> products;
  Order({
    required this.id,
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
    required this.discount,
    required this.discountType,
    required this.marketerId,
    required this.marketerFeeType,
    required this.products,
  });

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
      total: map['total'] as num,
      userId: map['user_id'] as int,
      customerId: map['customer_id'] as int,
      notes: map['notes'] ?? '',
      type: map['type'] as String,
      paidUp: map['paid_up'] as int,
      restOfTheBill: map['rest_of_the_bill'] as num,
      wareId: map['ware_id'] as int,
      toWareId: map['to_ware_id'] ?? 0.0,
      bankId: map['bank_id'] as int,
      sellType: map['sell_type'],
      status: map['status'] as int,
      expenses: map['expenses'] ?? 0.0,
      discount: map['discount'] ?? 0.0,
      discountType: map["discount_type"] ?? '',
      marketerId: map["marketer_id"] ?? 0,
      marketerFeeType: map["marketer_fee_type"] ?? '',
      products: map["products"] ?? [],
    );
  }
}
