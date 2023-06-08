import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class PaymentsClient {
  Future<dynamic> getPayments() async {
    var response =
        await http.get(Uri.parse("$baseUrl$paymentsLink/${MyApp.appUser!.id}"));
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
