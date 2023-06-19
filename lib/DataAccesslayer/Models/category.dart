class Category {
  final int id;
  final String name;
  final int? parentId;

  Category({
    required this.id,
    required this.name,
    this.parentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parent': parentId,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] ?? '',
      parentId: map['parent'],
    );
  }
}
