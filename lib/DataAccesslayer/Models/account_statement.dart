import 'package:matjary/DataAccesslayer/Models/account_movement.dart';

class AccountStatement {
  final num total;
  final List<AccountMovement> statements;

  AccountStatement({
    required this.total,
    required this.statements,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'accountStatement': statements,
    };
  }

  factory AccountStatement.fromMap(Map<String, dynamic> map) {
    return AccountStatement(
      total: map['total'],
      statements: map['accountStatement']
          .map((statement) => AccountMovement.fromMap(statement))
          .toList(),
    );
  }
}
