import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class ReportsClient {
  Future<dynamic> getWareReports(wareId) async {
    var response =
        await http.get(Uri.parse("$baseUrl$wareContentLink/$wareId"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getProductReports(productId) async {
    var response =
        await http.get(Uri.parse("$baseUrl$productReportLink/$productId"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
