import 'dart:convert';
import '../Clients/ware_client.dart';
import '../Models/ware.dart';


class WareRepo{
var client = WareClient();
  Future<List<Ware>> postWare(name, userId) async {
    var data = await client.postWare(name, userId);
    print(data);
    if (data != null) {
      final parsed = json.decode(data).cast<Map<String, dynamic>>();
      return parsed.map<Ware>((json) => Ware.fromMap(json)).toList();
    }
    return [];
  }
}