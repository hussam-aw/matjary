import 'dart:convert';

import 'package:matjary/DataAccesslayer/Clients/reports_client.dart';
import 'package:matjary/DataAccesslayer/Models/product_movement.dart';
import 'package:matjary/DataAccesslayer/Models/product_report.dart';
import 'package:matjary/DataAccesslayer/Models/product_with_quantity.dart';

class ReportsRepo {
  ReportsClient client = ReportsClient();

  Future<List<ProductWithQuantity>> getWareReport(wareId) async {
    var response = await client.getWareReport(wareId);
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductWithQuantity>((json) => ProductWithQuantity.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<ProductReport?> getProductReport(productId) async {
    var response = await client.getProductReport(productId);
    if (response != "") {
      final parsed = json.decode(response);
      return ProductReport.fromMap(parsed);
    }
    return null;
  }

  Future<List<ProductReport>> getAllProductsReports() async {
    var response = await client.getAllProductReports();
    if (response != "") {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductReport>((json) => ProductReport.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<List<ProductMovement>> getProductMovementReport(productId) async {
    var response = await client.getProductMovementReport(productId);
    if (response != "") {
      final parsed = json.decode(response);
      return parsed
          .map<ProductMovement>((json) => ProductMovement.fromJson(json))
          .toList();
    }
    return [];
  }
}
