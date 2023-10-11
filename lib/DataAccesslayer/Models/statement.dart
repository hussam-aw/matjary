class Statement {
  int firstSideId;
  int secondSideId;
  String type;
  String statement;
  num amount;
  DateTime createdAt;

  Statement({
    required this.firstSideId,
    required this.secondSideId,
    required this.type,
    required this.statement,
    required this.amount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_side_id': firstSideId,
      'second_side_id': secondSideId,
      'type': type,
      'statement': statement,
      'amount': amount,
      'created_at': createdAt,
    };
  }

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      firstSideId: map['first_side'] as int,
      secondSideId: map['other_side'] as int,
      type: '',
      statement: map['statement'] ?? '',
      amount: map['amount'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
