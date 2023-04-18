import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class AccountsClient {
  Future<dynamic> getAccounts() async {
    var response = await http.get(Uri.parse("$baseUrl$accountsLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
