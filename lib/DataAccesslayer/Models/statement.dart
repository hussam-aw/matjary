class Statement {
  int firstSideId;
  int secondSideId;
  String statement;
  num amount;
  DateTime date;

  Statement({
    required this.firstSideId,
    required this.secondSideId,
    required this.statement,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_side_id': firstSideId,
      'second_side_id': secondSideId,
      'statement': statement,
      'amount': amount,
      'date': date,
    };
  }

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      firstSideId: map['first_side_id'] as int,
      secondSideId: map['second_side_id'] as int,
      statement: map['statement'] ?? '',
      amount: num.parse(map['amount']),
      date: DateTime.parse(map['date']),
    );
  }
}
