import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:matjary/DataAccesslayer/Clients/store_settings_client.dart';
import 'package:matjary/DataAccesslayer/Models/store_settings.dart';

class StoreSettingsRepo {
  StoreSettingsClient client = StoreSettingsClient();

  Future<StoreSettings?> getStoreSettings() async {
    var response = await client.getStoreSettings();
    if (response != "") {
      if (kDebugMode) {
        print(response);
      }
      final parsed = json.decode(response);
      return StoreSettings.fromJson(parsed);
    }
    return null;
  }

  Future<StoreSettings?> updateStoreSettings(
      name, icon, defaultWare, defaultBank, currencies) async {
    var data = await client.updateStoreSettings(
        name, icon, defaultWare, defaultBank, currencies);

    if (data != null) {
      final parsed = json.decode(data);
      return StoreSettings.fromJson(parsed);
    }
    return null;
  }
}
