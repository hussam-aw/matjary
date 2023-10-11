import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:matjary/PresentationLayer/Widgets/snackbars.dart';

class ConnectivityController extends GetxController {
  final Connectivity connectivity = Connectivity();
  final RxBool _isConnected = true.obs;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool isFirstChange = true;

  void _initializeConnectivity() async {
    final ConnectivityResult result = await connectivity.checkConnectivity();
    _updateConnectivityStatus(result);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    _isConnected.value = (result != ConnectivityResult.none);
    if (!isFirstChange) {
      if (isConnected) {
        SnackBars.showSuccess('متصل بالانترنت');
      } else {
        SnackBars.showError('غير متصل بالانترنت');
      }
    } else {
      isFirstChange = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  bool get isConnected => _isConnected.value;
}
