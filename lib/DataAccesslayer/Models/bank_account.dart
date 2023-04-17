import 'package:matjary/DataAccesslayer/Models/account.dart';

class BankAccount extends Account {
  BankAccount({
    required super.id,
    required super.name,
    required super.balance,
    required super.type,
    required super.style,
    required super.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'balance': balance,
      'type': type,
      'style': style,
      'user_id': userId,
    };
  }

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      balance: map['balance'] ?? 0.0,
      type: map['type'] ?? 0,
      style: map['style'] ?? 0,
      userId: map['user_id'] ?? 0,
    );
  }
}
