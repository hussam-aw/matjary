import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/connectivity_controller.dart';
import 'package:matjary/BussinessLayer/helpers/database_helper.dart';
import 'package:matjary/Constants/app_strings.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/ware_repo.dart';

class WaresController extends GetxController {
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  var isLoadingWares = false.obs;
  final connectivityController = Get.find<ConnectivityController>();
  DatabaseHelper databaseHelper = DatabaseHelper.db;

  Future<void> getWares() async {
    isLoadingWares.value = true;
    wares = await wareRepo.getWares(connectivityController.isConnected);
    isLoadingWares.value = false;
    backupWares();
  }

  Future<void> backupWares() async {
    if (connectivityController.isConnected) {
      await databaseHelper.clearTable(waresTableName);
      for (var ware in wares) {
        await databaseHelper.insert(waresTableName, ware.toMap());
      }
    }
  }

  Ware? getWareFromId(wareId) {
    var ware = wares.firstWhereOrNull((ware) => ware.id == wareId);
    if (ware != null) {
      return ware;
    }
    return null;
  }

  String getWareName(int? id) {
    return getWareFromId(id) != null ? getWareFromId(id)!.name : '';
  }
}
