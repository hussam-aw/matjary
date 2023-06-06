class Payment {
  String type;
  int counterPartyId;
  int bankId;
  String statement;
  num amount;
  DateTime date;

  Payment({
    required this.type,
    required this.counterPartyId,
    required this.bankId,
    required this.statement,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "type": type,
      "account_id": counterPartyId,
      "bank_id": bankId,
      "amount": amount,
      "statement": statement,
      "created_at": date,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      type: map["type"],
      counterPartyId: map["first_side_id"] as int,
      bankId: map["second_side_id"] as int,
      amount: map["amount"],
      statement: map["statement"] ?? '',
      date: DateTime.parse(map['created_at']),
    );
  }

  String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }
}
