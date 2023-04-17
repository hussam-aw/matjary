import 'package:matjary/DataAccesslayer/Models/account.dart';

class ClientAccount extends Account {
  ClientAccount({
    required super.id,
    required super.name,
    required super.balance,
    required super.email,
    required super.address,
    required super.mobileNumber,
    required super.type,
    required super.style,
    required super.userId,
    required super.salary,
    required super.salaryCurrency,
    required super.accountingName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': mobileNumber,
      'balance': balance,
      'type': type,
      'style': style,
      'user_id': userId,
      'salary': salary,
      'salary_currency': salaryCurrency,
      'accounting_name': accountingName,
    };
  }

  factory ClientAccount.fromMap(Map<String, dynamic> map) {
    return ClientAccount(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      mobileNumber: map['phone'] ?? '',
      balance: map['balance'] ?? 0.0,
      type: map['type'] ?? 0,
      style: map['style'] ?? 0,
      userId: map['user_id'] ?? 0,
      salary: map['salary'] ?? 0.0,
      salaryCurrency: map['salary_currency'] ?? '',
      accountingName: map['accounting_name'] ?? '',
    );
  }
}
