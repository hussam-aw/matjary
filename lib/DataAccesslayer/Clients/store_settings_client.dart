import 'package:http/http.dart' as http;
import 'package:matjary/main.dart';
import '../../Constants/api_links.dart';

class StoreSettingsClient {
  Future<dynamic> getStoreSettings() async {
    var response = await http
        .get(Uri.parse("$baseUrl$settingsLink/${MyApp.appUser!.companyId}"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  Future<dynamic> updateStoreSettings(
      name, icon, defaultWare, defaultBank, currencies) async {
    var request =
        http.MultipartRequest('Post', Uri.parse('$baseUrl$settingsLink'));
    request.fields.addAll({
      'name': name.toString(),
      "default_ware": defaultWare.toString(),
      "default_bank": defaultBank.toString(),
      'user_id': MyApp.appUser!.companyId.toString(),
    });

    // for (String currency in currencies) {
    //   request.files
    //       .add(http.MultipartFile.fromString("currencies[]", currency));
    // }

    if (icon.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('icon', icon));
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }
}
