import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/main.dart';

import '../../Constants/api_links.dart';

class UserClient {
  Future<dynamic> login(email, password) async {
    var response = await http.post(Uri.parse("$baseUrl$loginLink"),
        body:
            jsonEncode(<String, dynamic>{"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> createUser(
      type, userName, mobilePhone, password, notifiable) async {
    var response = await http.post(Uri.parse('$baseUrl$userLink'),
        body: jsonEncode(<String, dynamic>{
          "app_role": type,
          "name": userName,
          "email": mobilePhone,
          "phone": mobilePhone,
          "password": password,
          "notifiable": notifiable,
          "company_id": MyApp.appUser!.companyId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      return true;
    } else {
      return null;
    }
  }

  Future<dynamic> updateUserInfo(
      userName, mobilePhone, password, avatar) async {
    var response = await http.post(Uri.parse('$baseUrl$updateProfileLink'),
        body: jsonEncode(<String, dynamic>{
          "name": userName,
          "phone": mobilePhone,
          "password": password,
          "avatar": avatar,
          "user_id": MyApp.appUser!.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> getUserDataById(id) async {
    var response = await http.get(Uri.parse("$baseUrl$userLink/$id"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getUsers() async {
    var response = await http
        .get(Uri.parse("$baseUrl$usersLink/${MyApp.appUser!.companyId}"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
