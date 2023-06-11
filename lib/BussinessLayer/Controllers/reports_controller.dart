import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/product_report.dart';
import 'package:matjary/DataAccesslayer/Models/ware_report.dart';
import 'package:matjary/DataAccesslayer/Repositories/reports_repo.dart';

class ReportsController extends GetxController {
  List<WareReport> wareReports = [];
  ProductReport? productReport = null;
  List<ProductReport> productsReports = [];
  ReportsRepo reportsRepo = ReportsRepo();
  var isloading = false.obs;

  Future<void> getWareReports(wareId) async {
    isloading.value = true;
    wareReports = await reportsRepo.getWareReports(wareId);
    isloading.value = false;
  }

  Future<void> getProductReport(productId) async {
    isloading.value = true;
    productReport = await reportsRepo.getProductReport(productId);
    isloading.value = false;
  }

  Future<void> getAllProductsReports() async {
    isloading.value = true;
    productsReports = await reportsRepo.getAllProductsReports();
    isloading.value = false;
  }
}
