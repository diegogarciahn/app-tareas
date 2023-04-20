import 'dart:convert';

import 'package:app_tareas/models/models.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';

class ComentarioService {
  static Future<int> crearComentario(
      {required String contenido,
      required int idTarea,
      required String token}) async {
    final client = Client();
    final body = {
      'contenido': contenido,
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

  static Future traerComentarios(
      {required int idTarea, required String token}) async {
    final client = Client();
    try {
      var response = await client.get(
          Uri.parse('${apiUrl}comentario/tarea?idTarea=$idTarea'),
          headers: {
            'Authorization': 'Bearer $token'
          }).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return comentariosFromJson(response.body);
      }
      return response.statusCode;
    } catch (e) {
      client.close();
      return getCodErrorService(e);
    }
  }
}
