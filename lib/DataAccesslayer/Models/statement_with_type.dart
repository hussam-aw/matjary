import 'package:matjary/DataAccesslayer/Models/account.dart';

class StatementWithType {
  final int id;
  final String type;
  final String statement;
  final num amount;
  final Account bank;
  final DateTime date;

  StatementWithType({
    required this.id,
    required this.type,
    required this.statement,
    required this.amount,
    required this.bank,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "statement": statement,
      "amount": amount,
      "bank": bank,
      "date": date,
    };
  }

  factory StatementWithType.fromMap(Map<String, dynamic> map) {
    return StatementWithType(
      id: map["id"],
      type: map["type"],
      statement: map["statement"] ?? '',
      amount: map["amount"],
      bank: Account.fromMap(map["other_side"]),
      date: DateTime.parse(map['created_at']),
    );
  }

  String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }
}
