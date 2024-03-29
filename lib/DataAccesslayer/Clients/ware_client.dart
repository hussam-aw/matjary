import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/main.dart';
import '../../Constants/api_links.dart';

class WareClient {
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<dynamic> getWares(connected) async {
    if (connected) {
      var response = await http
          .get(Uri.parse("$baseUrl$waresLink/${MyApp.appUser!.companyId}"));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } else {
      var data = await databaseHelper.getAllTableData(waresTableName);
      if (data.isNotEmpty) {
        return data;
      } else {
        return "";
      }
    }
  }

  Future<dynamic> craeteWare(name) async {
    var response = await http.post(Uri.parse("$baseUrl$wareLink"),
        //var response = await http.post(Uri.parse("http://matjary2.brain.sy/api/v1/ware"),
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "user_id": MyApp.appUser!.id,
          "company_id": MyApp.appUser!.companyId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
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
          "company_id": MyApp.appUser!.companyId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> deleteWare(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$wareLink/$id'));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
