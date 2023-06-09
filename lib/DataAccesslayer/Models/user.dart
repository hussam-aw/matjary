import 'dart:convert';

class User {
  final int id;
  final String name;
  final int companyId;
  final String mobileNumber;
  final String email;
  final String address;
  final DateTime expiryDate;
  final String avatar;
  final String token;
  User({
    required this.id,
    required this.companyId,
    required this.mobileNumber,
    required this.name,
    required this.email,
    required this.address,
    required this.expiryDate,
    required this.avatar,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'company_id': companyId,
      'mobile_number': mobileNumber,
      'name': name,
      'email': email,
      'address': address,
      'expiry_date': expiryDate.toString(),
      'avatar': avatar,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['id']?.toInt() ?? 0,
      companyId: map['user']['company_id'] ?? 0,
      mobileNumber: map['user']['mobile_number'] ?? '',
      name: map['user']['name'] ?? '',
      email: map['user']['email'] ?? '',
      address: map['user']['address'] ?? '',
      expiryDate: DateTime.parse(map['user']['expiry_date']),
      avatar: map['user']['avatar'] ?? '',
      token: map['token'] ?? '',
    );
  }
  factory User.fromBoxMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      companyId: map['company_id'],
      mobileNumber: map['mobile_number'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      expiryDate: DateTime.parse(map['expiry_date']),
      avatar: map['avatar'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  String getDateString(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day}";
  }
}
