import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/product_report.dart';
import 'package:matjary/DataAccesslayer/Models/ware_report.dart';
import 'package:matjary/DataAccesslayer/Repositories/reports_repo.dart';

class ReportsController extends GetxController {
  List<WareReport> wareReports = [];
  List<ProductReport> productReports = [];
  ReportsRepo reportsRepo = ReportsRepo();
  var isloading = false.obs;

  Future<void> getWareReports(wareId) async {
    isloading.value = true;
    wareReports = await reportsRepo.getWareReports(wareId);
    isloading.value = false;
  }

  Future<void> getProductReports(productId) async {
    isloading.value = true;
    productReports = await reportsRepo.getProductReports(productId);
    isloading.value = false;
  }
}
