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
      print("accounts : ");
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } else {
      var data = await databaseHelper.getData(accountTableName);
      if (data.isNotEmpty) {
        return data;
      } else {
        return "";
      }
    }
  }

  // Future<dynamic> getBankAccounts() async {
  //   var response = await http.get(Uri.parse("$baseUrl$bankAccountsLink"));

  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return "";
  //   }
  // }

  // Future<dynamic> getClientAccounts() async {
  //   var response = await http
  //       .get(Uri.parse("$baseUrl$clientAccoutsLink/${MyApp.appUser!.id}"));

  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return "";
  //   }
  // }

  Future<dynamic> getCashAmount() async {
    var response = await http
        .get(Uri.parse("$baseUrl$cashAmountLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createAccount(connected, map) async {
    if (connected) {
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
      } else {
        return null;
      }
    } else {
      try {
        await databaseHelper.insert(accountTableName, map);
        return true;
      } catch (e) {
        return null;
      }
    }
  }

  Future<dynamic> updateAccount(id, name, balance, type, style, image) async {
    var request =
        http.MultipartRequest('Post', Uri.parse('$baseUrl$accountLink/$id'));
    request.fields.addAll({
      'name': name.toString(),
      "balance": balance.toString(),
      "type": type.toString(),
      "style": style.toString(),
      "user_id": MyApp.appUser!.id.toString(),
      'company_id': MyApp.appUser!.companyId.toString(),
    });

    if (image.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('avatar', image));
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }

  Future<dynamic> deleteAccount(connected, id) async {
    if (connected) {
      var response = await http.delete(Uri.parse('$baseUrl$accountLink/$id'));

      if (response.statusCode == 201) {
        return true;
      } else {
        return null;
      }
    } else {
      try {
        await databaseHelper.delete(accountTableName, id);
        return true;
      } catch (e) {
        return null;
      }
    }
  }
}
