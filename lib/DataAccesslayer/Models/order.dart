import 'dart:convert';

import 'order_product.dart';

class Order {
  final int id;
  final num total;
  final int userId;
  final int customerId;
  final String notes;
  final String type;
  final num paidUp;
  final num restOfTheBill;
  final int wareId;
  final num toWareId;
  final int bankId;
  final String sellType;
  final int status;
  final num? expenses;
  final num? discount;
  final String discountType;
  final int? marketerId;
  final String marketerFeeType;
  final num? marketerFee;
  final List<OrderProduct> details;
  final DateTime creationDate;
  final DateTime updationDate;
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
    required this.marketerFee,
    required this.details,
    required this.creationDate,
    required this.updationDate,
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
      'discount': discount,
      'discount_type': discountType,
      'marketer_id': marketerId,
      'marketer_fee_type': marketerFeeType,
      'marketer_fee': marketerFee,
      'details': details.map((product) => product.toJson()).toList(),
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
      paidUp: map['paid_up'] as num,
      restOfTheBill: map['rest_of_the_bill'] ?? 0.0,
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
      marketerFee: map['marketer_fee'] ?? 0.0,
      details: getDetailsList(map["details"]),
      creationDate: getDate(map["created_at"]),
      updationDate: getDate(map["updated_at"]),
    );
  }

  static List<OrderProduct> getDetailsList(details) {
    List<OrderProduct> result = [];
    dynamic parsed;
    if (details is String) {
      parsed = json.decode(details);
    } else {
      parsed = details;
    }
    if (parsed != null) {
      for (int i = 0; i < parsed.length; i++) {
        result.add(OrderProduct.fromJson(parsed[i]));
      }
    }
    return result;
  }

  String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }

  static DateTime getDate(String date) {
    return DateTime.parse(date);
  }
}
