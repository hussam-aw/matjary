import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool _isConnected = true.obs;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  void _initializeConnectivity() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateConnectivityStatus(result);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    _isConnected.value = (result != ConnectivityResult.none);
  }

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  bool get isConnected => _isConnected.value;
}
