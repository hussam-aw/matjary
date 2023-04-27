import 'dart:convert';

import '../Clients/ware_client.dart';
import '../Models/ware.dart';

class WareRepo {
  var client = WareClient();

  Future<List<Ware>> getWares() async {
    var response = await client.getWares();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Ware>((json) => Ware.fromMap(json)).toList();
    }
    return [];
  }

  Future<Ware?> postWare(name, userId) async {
    var data = await client.postWare(name, userId);

    if (data != null) {
      final parsed = json.decode(data);
      return Ware.fromMap(parsed);
    }
    return null;
  }

  Future<Ware?> updateWare(id, name) async {
    var updatedAccount = await client.updateWare(id, name);
    print(updatedAccount);
    if (updatedAccount != null) {
      return Ware.fromMap(jsonDecode(updatedAccount));
    }
    return null;
  }

  Future<Ware?> deleteWare(id) async {
    var deletedWare = await client.deleteWare(id);
    print(deletedWare);
    if (deletedWare != null) {
      return Ware.fromMap(jsonDecode(deletedWare));
    }
    return null;
  }
}
