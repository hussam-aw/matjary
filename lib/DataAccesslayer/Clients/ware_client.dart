import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Constants/api_links.dart';

class WareClient {
  Future<dynamic> getWares() async {
    var response = await http.get(Uri.parse("$baseUrl$waresLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> postWare(name, userId) async {
    var response = await http.post(Uri.parse("$baseUrl$createWare"),
        //var response = await http.post(Uri.parse("http://matjary2.brain.sy/api/v1/ware"),
        body: jsonEncode(<String, String>{
          "name": name,
          "user_id": userId.toString(),
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
}
