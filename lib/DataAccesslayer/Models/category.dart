class Category {
  final int id;
  final String name;
  final String parent;

  Category({
    required this.id,
    required this.name,
    required this.parent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parent': parent,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] ?? '',
      parent: map['parent'] ?? '',
    );
  }
}
