class Account {
  final int id;
  final String name;
  final String? email;
  final String? address;
  final String? mobileNumber;
  final num balance;
  final int type;
  final int style;
  final int? userId;
  final double? salary;
  final String? salaryCurrency;
  final String? accountingName;
  final String? avatar;

  Account({
    required this.id,
    required this.name,
    this.email,
    this.address,
    this.mobileNumber,
    required this.balance,
    required this.type,
    required this.style,
    this.userId,
    this.salary,
    this.salaryCurrency,
    this.accountingName,
    this.avatar,
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
      'avatar': avatar,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      mobileNumber: map['phone'] ?? '',
      balance: map['balance'] ?? 0,
      type: map['type'] ?? 0,
      style: map['style'] ?? 0,
      avatar: map['avatar'],
    );
  }
}
