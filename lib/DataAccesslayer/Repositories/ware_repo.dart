import 'dart:convert';
import '../Clients/ware_client.dart';
import '../Models/ware.dart';


class WareRepo{
var client = WareClient();
  Future<Ware?> postWare(name, userId) async {
    var data = await client.postWare(name, userId);
    print(data);
    if (data != null) {
      return Ware.fromMap(jsonDecode(data));
    }
    return null;
  }
}