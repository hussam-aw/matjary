import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';
import 'package:matjary/main.dart';

class ReportsClient {
  Future<dynamic> getWareReport(wareId) async {
    var response =
        await http.get(Uri.parse("$baseUrl$wareContentLink/$wareId"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getProductReport(productId) async {
    var response = await http.get(Uri.parse(
        "$baseUrl$productReportLink/${MyApp.appUser!.id}/$productId"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> getAllProductReports() async {
    var response = await http
        .get(Uri.parse("$baseUrl$allproductsReportLink/${MyApp.appUser!.id}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
