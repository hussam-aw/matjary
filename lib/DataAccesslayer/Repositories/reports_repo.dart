import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/reports_client.dart';
import 'package:matjary/DataAccesslayer/Models/product_report.dart';
import 'package:matjary/DataAccesslayer/Models/ware_report.dart';

class ReportsRepo {
  ReportsClient client = ReportsClient();

  Future<List<WareReport>> getWareReports(wareId) async {
    var response = await client.getWareReports(wareId);
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<WareReport>((json) => WareReport.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<List<ProductReport>> getProductReports(productReport) async {
    var response = await client.getProductReports(productReport);
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductReport>((json) => ProductReport.fromMap(json))
          .toList();
    }
    return [];
  }
}
