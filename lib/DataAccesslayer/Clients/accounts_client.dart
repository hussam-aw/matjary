// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/main.dart';

class AccountsClient {
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<dynamic> getAccounts(connected) async {
    if (connected) {
      var response = await http
          .get(Uri.parse("$baseUrl$accountsLink/${MyApp.appUser!.companyId}"));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } else {
      var data = await databaseHelper.getData(accountsTableName);
      if (data.isNotEmpty) {
        return data;
      } else {
        return "";
      }
    }
  }

  Future<dynamic> getCashAmount() async {
    var response = await http
        .get(Uri.parse("$baseUrl$cashAmountLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createAccount(map) async {
    var request =
        http.MultipartRequest('Post', Uri.parse('$baseUrl$accountLink'));
    request.fields.addAll(map['primaryFileds']);
    if (map['files'].isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', map['files']),
      );
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<dynamic> updateAccount(id, map) async {
    var request =
        http.MultipartRequest('Post', Uri.parse('$baseUrl$accountLink/$id'));
    request.fields.addAll(map['primaryFileds']);
    if (map['files'].isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', map['files']),
      );
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<dynamic> deleteAccount(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$accountLink/$id'));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
