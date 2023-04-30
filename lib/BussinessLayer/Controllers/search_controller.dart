import 'package:get/state_manager.dart';

import '../../DataAccesslayer/Models/product.dart';
import '../../DataAccesslayer/Repositories/products_repo.dart';

class SearchController extends GetxController {
  List<dynamic> list = [];
  List<dynamic> filteredList = [];
  String searchText = "";
  var searchLoading = false.obs;

  void search() async {
    if (searchText.isNotEmpty) {
      searchLoading.value = true;
      filteredList = list
          .where((item) =>
              item.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      searchLoading.value = false;
    } else {
      filteredList.clear();
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    filteredList.clear();
    super.onClose();
  }
}
