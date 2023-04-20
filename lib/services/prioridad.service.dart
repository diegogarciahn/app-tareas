import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';
import '../models/models.dart';

class PrioridadService {
  static Future<int> crearPrioridad(
      {required String nombre, required String token}) async {
    final client = Client();
    final body = {
      'nombre': nombre,
    };
    try {
      var response = await client.post(Uri.parse('${apiUrl}prioridad/'),
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

  static Future traerPrioridads(String token) async {
    final client = Client();
    try {
      var response = await client.get(Uri.parse('${apiUrl}prioridad'),
          headers: {'x-token': token}).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return prioridadesFromJson(response.body);
      }
      return response.statusCode;
    } catch (e) {
      client.close();
      return getCodErrorService(e);
    }
  }

  static Future<int> actualizarPrioridad(
      {required int idPrioridad,
      required String nombre,
      required String token}) async {
    final client = Client();
    final body = {
      'idPrioridad': idPrioridad,
      'nombre': nombre,
    };
    try {
      var response = await client.put(Uri.parse('${apiUrl}prioridad/'),
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

  static Future<int> eliminarPrioridad(
      {required int idPrioridad,
      required String token}) async {
    final client = Client();
    final body = {
      "idPrioridad": idPrioridad,
    };
    try {
      var response = await client.delete(Uri.parse('${apiUrl}prioridad/'),
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
