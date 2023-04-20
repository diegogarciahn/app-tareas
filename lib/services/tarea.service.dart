import 'dart:convert';

import 'package:app_tareas/models/models.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';

class TareaService {
  static Future<int> crearTarea(
      {required String titulo,
      required String descripcion,
      required int idCategoria,
      required int idPrioridad,
      required String token}) async {
    final client = Client();
    final body = {
      "titulo": titulo,
      "descripcion": descripcion,
      "estado": "pendiente",
      "idCategoria": idCategoria,
      "idPrioridad": idPrioridad,
    };
    try {
      var response = await client.post(Uri.parse('${apiUrl}tarea/'),
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

  static Future traerTareas(String token) async {
    final client = Client();
    try {
      var response = await client.get(Uri.parse('${apiUrl}categoria'),
          headers: {'x-token': token}).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return categoriasFromJson(response.body);
      }
      return response.statusCode;
    } catch (e) {
      client.close();
      return getCodErrorService(e);
    }
  }

  static Future<int> actualizarTarea(
      {required int idTarea,
      required String nombreTarea,
      required String descripcion,
      required String token}) async {
    final client = Client();
    final body = {
      "idTarea": idTarea,
      "nombre": nombreTarea,
      "descripcion": descripcion,
    };
    try {
      var response = await client.put(Uri.parse('${apiUrl}categoria/'),
          body: jsonEncode(body),
          headers: {
            'x-token': token,
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 30));

      return response.statusCode;
    } catch (e) {
      return getCodErrorService(e);
    }
  }

  static Future<int> eliminarTarea(
      {required int idTarea, required String token}) async {
    final client = Client();
    final body = {
      "idTarea": idTarea,
    };
    try {
      var response = await client.delete(Uri.parse('${apiUrl}categoria/'),
          body: jsonEncode(body),
          headers: {
            'x-token': token,
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 30));

      return response.statusCode;
    } catch (e) {
      return getCodErrorService(e);
    }
  }
}
