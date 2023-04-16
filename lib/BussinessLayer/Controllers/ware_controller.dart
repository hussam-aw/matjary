import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../DataAccesslayer/Clients/box_client.dart';
import '../../DataAccesslayer/Repositories/ware_repo.dart';



class WareController extends GetxController{
  BoxClient boxClient = BoxClient();
  WareRepo wareRepo = WareRepo();
  var sending = false.obs;
TextEditingController nameOfWareController = TextEditingController();

}