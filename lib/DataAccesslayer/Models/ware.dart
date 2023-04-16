import 'dart:convert';

class Ware{
  final int id;
  final String name;
  final String userId;

  Ware({
    required this.id,
    required this.name,
   required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'user_id': userId,
    };
  }
  factory Ware.fromMap(Map<String, dynamic> map) {
    return Ware(
      id: map['id'] as int,
      name: map['name'] as String,
      userId:map['user_id'] as String,

    );
  }
}