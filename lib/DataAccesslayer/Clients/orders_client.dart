import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class OrdersClient {
  Future<dynamic> getOrders() async {
    var response = await http.get(Uri.parse("$baseUrl$ordersLink"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
