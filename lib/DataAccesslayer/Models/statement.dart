class Statement {
  int firstSideId;
  int secondSideId;
  String type;
  String statement;
  num amount;
  DateTime date;

  Statement({
    required this.firstSideId,
    required this.secondSideId,
    required this.type,
    required this.statement,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_side_id': firstSideId,
      'second_side_id': secondSideId,
      'type': type,
      'statement': statement,
      'amount': amount,
      'date': date,
    };
  }

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      firstSideId: map['first_side_id'] as int,
      secondSideId: map['second_side_id'] as int,
      type: '',
      statement: map['statement'] ?? '',
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}
