import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  static Future<dynamic> getRequest(String url) async {
    // ignore: no_leading_underscores_for_local_identifiers
    var _url = Uri.parse(url);
    http.Response reponse = await http.get(_url);

    try {
      if (reponse.statusCode == 200) {
        String data = reponse.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
