import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Constants/api_links.dart';

class WareClient{
  Future<dynamic> postWare(name, userId) async {
    var response = await http.post(Uri.parse("$baseUrl$createWare"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
print(response.statusCode);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}