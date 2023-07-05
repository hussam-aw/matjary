import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Constants/api_links.dart';

class UserClient {
  Future<dynamic> login(email, password) async {
    var response = await http.post(Uri.parse("$baseUrl$loginLink"),
        body:
            jsonEncode(<String, dynamic>{"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
