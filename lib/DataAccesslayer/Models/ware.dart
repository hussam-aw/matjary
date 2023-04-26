class Ware {
  final int id;
  final String name;

  Ware({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Ware.fromMap(Map<String, dynamic> map) {
    return Ware(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
