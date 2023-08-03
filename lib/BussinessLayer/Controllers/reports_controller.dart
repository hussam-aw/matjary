import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/product_movement.dart';
import 'package:matjary/DataAccesslayer/Models/product_report.dart';
import 'package:matjary/DataAccesslayer/Models/product_with_quantity.dart';
import 'package:matjary/DataAccesslayer/Repositories/reports_repo.dart';

class ReportsController extends GetxController {
  List<ProductWithQuantity> productsWithQuantity = [];
  ProductReport? productReport;
  List<ProductReport> productsReports = [];
  List<ProductMovement> productMovements = [];
  ReportsRepo reportsRepo = ReportsRepo();
  var isLoadingWareReport = false.obs;
  var isLoadingProductReport = false.obs;
  var isLoadingAllProductsReports = false.obs;
  var isLoadingProductMovementReport = false.obs;

  Future<void> getWareReport(wareId) async {
    isLoadingWareReport.value = true;
    productsWithQuantity = await reportsRepo.getWareReport(wareId);
    isLoadingWareReport.value = false;
  }

  Future<void> getProductReport(productId) async {
    isLoadingProductReport.value = true;
    productReport = await reportsRepo.getProductReport(productId);
    isLoadingProductReport.value = false;
  }

  Future<void> getAllProductsReports() async {
    isLoadingAllProductsReports.value = true;
    productsReports = await reportsRepo.getAllProductsReports();
    isLoadingAllProductsReports.value = false;
  }

  Future<void> getProductMovementReport(productId, wareName) async {
    isLoadingProductMovementReport.value = true;
    productMovements = await reportsRepo.getProductMovementReport(productId);
    if (wareName != null) {
      productMovements = productMovements
          .where((movement) => movement.ware == wareName)
          .toList();
    }
    isLoadingProductMovementReport.value = false;
  }
}
