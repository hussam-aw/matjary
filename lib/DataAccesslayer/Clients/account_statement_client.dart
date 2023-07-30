import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class AccountStatementClient {
  Future<dynamic> getAccountStatementBasedOnType(
      type, accountId, fromDate, toDate) async {
    var response =
        await http.post(Uri.parse('$baseUrl$accountStatementByDateLink'),
            body: jsonEncode(<String, dynamic>{
              "type": type,
              "account_id": accountId,
              "from_date": fromDate,
              "to_date": toDate,
            }),
            headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
