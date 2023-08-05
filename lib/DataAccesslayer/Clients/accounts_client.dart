import 'package:matjary/main.dart';
import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class AccountsClient {
  Future<dynamic> getAccounts() async {
    var response = await http
        .get(Uri.parse("$baseUrl$accountsLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
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
        .get(Uri.parse("$baseUrl$cashAmountLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> createAccount(
      name, balance, type, style, email, address, mobileNumber, image) async {
    var request =
        http.MultipartRequest('Post', Uri.parse('$baseUrl$accountLink'));
    request.fields.addAll({
      'name': name.toString(),
      "balance": balance.toString(),
      "type": type.toString(),
      "style": style.toString(),
      "email": email.toString(),
      "address": address.toString(),
      "phone": mobileNumber.toString(),
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

  Future<dynamic> deleteAccount(id) async {
    var response = await http.delete(Uri.parse('$baseUrl$accountLink/$id'));

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
