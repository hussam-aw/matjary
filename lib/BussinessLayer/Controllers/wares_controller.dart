import 'package:get/get.dart';
import 'package:matjary/DataAccesslayer/Models/ware.dart';
import 'package:matjary/DataAccesslayer/Repositories/ware_repo.dart';

class WaresController extends GetxController {
  WareRepo wareRepo = WareRepo();
  List<Ware> wares = [];
  var isLoadingWares = false.obs;

  Future<void> getWares() async {
    isLoadingWares.value = true;
    wares = await wareRepo.getWares();
    isLoadingWares.value = false;
  }

  Ware? getWareFromId(wareId) {
    var ware = wares.firstWhereOrNull((ware) => ware.id == wareId);
    if (ware != null) {
      return ware;
    }
    return null;
  }

  String getWareName(int id) {
    return getWareFromId(id) != null ? getWareFromId(id)!.name : '';
  }
}
