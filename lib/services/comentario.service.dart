import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';

class ComentarioService {
  static Future<int> crearComentario(
      {required String contenido,
      required int idUsuario,
      required int idTarea,
      required String token}) async {
    final client = Client();
    final body = {
      'contenido': contenido,
      'idUsuario': idUsuario,
      'idTarea': idTarea,
    };
    try {
      var response = await client.post(Uri.parse('${apiUrl}comentario/'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 30));

      return response.statusCode;
    } catch (e) {
      return getCodErrorService(e);
    }
  }
}
