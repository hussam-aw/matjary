import 'package:get/get.dart';
import 'package:matjary/BussinessLayer/Controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
