class AccountMovement {
  String type;
  String statement;
  num amount;
  DateTime date;

  AccountMovement({
    required this.type,
    required this.statement,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'statement': statement,
      'amount': amount,
      'date': date,
    };
  }

  factory AccountMovement.fromMap(Map<String, dynamic> map) {
    return AccountMovement(
      type: '',
      statement: map['statement'] ?? '',
      amount: map['amount'],
      date: DateTime.parse(map['created_at']),
    );
  }
}
