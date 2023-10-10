import 'package:matjary/DataAccesslayer/Models/account.dart';

class Payment {
  int id;
  String type;
  Account counterParty;
  Account bank;
  String statement;
  num amount;
  DateTime createdAt;

  Payment({
    required this.id,
    required this.type,
    required this.counterParty,
    required this.bank,
    required this.statement,
    required this.amount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "account_id": counterParty,
      "bank_id": bank,
      "amount": amount,
      "statement": statement,
      "created_at": createdAt,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      type: map["type"],
      counterParty: Account.fromMap(map["first_side"]),
      bank: Account.fromMap(map["other_side"]),
      amount: map["amount"],
      statement: map["statement"] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
