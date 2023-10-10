import 'dart:convert';

class StoreSettings {
  int id;
  String name;
  String icon;
  int defaultWare;
  int defaultBank;
  List<String> currencies;
  DateTime? createdAt;

  StoreSettings({
    required this.id,
    required this.name,
    required this.icon,
    required this.defaultWare,
    required this.defaultBank,
    required this.currencies,
    required this.createdAt,
  });

  factory StoreSettings.fromJson(Map<String, dynamic> map) => StoreSettings(
        id: map["id"].toInt(),
        name: map["name"],
        icon: map["icon"],
        defaultWare: map["default_ware"] is String
            ? int.parse(map["default_ware"])
            : map["default_ware"],
        defaultBank: map["default_bank"] is String
            ? int.parse(map["default_bank"])
            : map["default_bank"],
        currencies: map["currencies"] is String
            ? List<String>.from(json.decode(map["currencies"]))
            : map["currencies"] ?? [],
        createdAt: map["created_at"].isNotEmpty
            ? DateTime.parse(map["created_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "default_ware": defaultWare,
        "default_bank": defaultBank,
        "currencies": json.encode(currencies),
        "created_at": createdAt!.toIso8601String(),
      };
}
