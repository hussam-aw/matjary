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

  factory StoreSettings.fromJson(Map<String, dynamic> json) => StoreSettings(
        id: json["id"].toInt(),
        name: json["name"],
        icon: json["icon"],
        defaultWare: json["default_ware"] is String
            ? int.parse(json["default_ware"])
            : json["default_ware"],
        defaultBank: json["default_bank"] is String
            ? int.parse(json["default_bank"])
            : json["default_bank"],
        currencies: json["currencies"] ?? [],
        createdAt: json["created_at"].isNotEmpty
            ? DateTime.parse(json["created_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "default_ware": defaultWare,
        "default_bank": defaultBank,
        "currencies": currencies,
        "created_at": createdAt!.toIso8601String(),
      };
}
