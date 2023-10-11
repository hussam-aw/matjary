class StatementWithType {
  final int id;
  final String type;
  final String statement;
  final num amount;
  final int bankId;
  final DateTime createdAt;

  StatementWithType({
    required this.id,
    required this.type,
    required this.statement,
    required this.amount,
    required this.bankId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "statement": statement,
      "amount": amount,
      "bank": bankId,
      "created_at": createdAt,
    };
  }

  factory StatementWithType.fromMap(Map<String, dynamic> map) {
    return StatementWithType(
      id: map["id"],
      type: map["type"],
      statement: map["statement"] ?? '',
      amount: map["amount"],
      bankId: map["other_side"]["id"],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  factory StatementWithType.fromDatabaseMap(Map<String, dynamic> map) {
    return StatementWithType(
      id: map["id"],
      type: map["type"],
      statement: map["statement"] ?? '',
      amount: map["amount"],
      bankId: map["other_side"],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }
}
