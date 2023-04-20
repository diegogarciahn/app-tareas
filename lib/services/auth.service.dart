import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';
import '../models/models.dart';

class AuthService {
  static Future loginService(String user, String passwd) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final cliente = Client();
    try {
      String credentials = "$user:$passwd";
      final body = {"idapp": 1};
      var response = await cliente.post(Uri.parse('${apiUrl}auth/'),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Basic ${stringToBase64.encode(credentials)}"
          }).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return tokenAndUserFromJson(response.body);
      }
      return response.statusCode;
    } catch (e) {
      return getCodErrorService(e);
    } finally {
      cliente.close();
    }
  }
}
