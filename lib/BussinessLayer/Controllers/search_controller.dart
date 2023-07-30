import 'package:get/state_manager.dart';

class ListSearchController extends GetxController {
  List<dynamic> list = [];
  List<dynamic> filteredList = [];
  String searchText = "";
  var searchLoading = false.obs;

  void setSearchList(searchList) {
    list = searchList;
  }

  void search(text) async {
    searchText = text;
    if (text.isNotEmpty) {
      searchLoading.value = true;
      filteredList = list
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();

      searchLoading.value = false;
    } else {
      filteredList.clear();
    }
    update();
  }

  @override
  void onClose() {
    filteredList.clear();
    super.onClose();
  }
}
