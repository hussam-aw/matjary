import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matjary/Constants/api_links.dart';

class StatementClinet {
  Future<dynamic> createStatement(
      firstSideId, secondSideId, userId, statement, amount, date) async {
    var response = await http.post(Uri.parse('$baseUrl$statementLink'),
        body: jsonEncode(<String, dynamic>{
          "first_side_id": firstSideId,
          "second_side_id": secondSideId,
          "user_id": userId,
          "statement": statement,
          "amount": amount,
          "date": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }
}
