class Payment {
  int id;
  String type;
  int counterPartyId;
  int bankId;
  String statement;
  num amount;
  DateTime createdAt;

  Payment({
    required this.id,
    required this.type,
    required this.counterPartyId,
    required this.bankId,
    required this.statement,
    required this.amount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "account_id": counterPartyId,
      "bank_id": bankId,
      "amount": amount,
      "statement": statement,
      "created_at": createdAt,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      type: map["type"],
      counterPartyId: map["first_side"]["id"],
      bankId: map["other_side"]["id"],
      amount: map["amount"],
      statement: map["statement"] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  factory Payment.fromDatabaseMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      type: map["type"],
      counterPartyId: map["first_side"],
      bankId: map["other_side"],
      amount: map["amount"],
      statement: map["statement"] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
