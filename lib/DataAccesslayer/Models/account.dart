class Account {
  final int id;
  final String name;
  final String email;
  final String address;
  final String mobileNumber;
  final int balance;
  final int type;
  final int style;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.mobileNumber,
    required this.balance,
    required this.type,
    required this.style,
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
    );
  }
}
