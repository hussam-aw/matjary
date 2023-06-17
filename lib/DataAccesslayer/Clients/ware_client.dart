import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matjary/main.dart';
import '../../Constants/api_links.dart';

class WareClient {
  Future<dynamic> getWares() async {
    var response =
        await http.get(Uri.parse("$baseUrl$waresLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> postWare(name, userId) async {
    var response = await http.post(Uri.parse("$baseUrl$wareLink"),
        //var response = await http.post(Uri.parse("http://matjary2.brain.sy/api/v1/ware"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": MyApp.appUser!.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> updateWare(id, name) async {
    var response = await http.post(Uri.parse('$baseUrl$wareLink/$id'),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": MyApp.appUser!.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteWare(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$wareLink/$id'));

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
