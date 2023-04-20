import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';
import '../models/models.dart';

class EtiquetaService {
  static Future<int> crearEtiqueta(
      {required String nombre, required String token}) async {
    final client = Client();
    final body = {
      'nombre': nombre,
    };
    try {
      var response = await client.post(Uri.parse('${apiUrl}etiqueta/'),
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

  static Future traerEtiquetas(String token) async {
    final client = Client();
    try {
      var response = await client.get(Uri.parse('${apiUrl}etiqueta'),
          headers: {'x-token': token}).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return etiquetasFromJson(response.body);
      }
      return response.statusCode;
    } catch (e) {
      client.close();
      return getCodErrorService(e);
    }
  }

  static Future<int> actualizarEtiqueta(
      {required int idEtiqueta,
      required String nombre,
      required String token}) async {
    final client = Client();
    final body = {
      'idEtiqueta': idEtiqueta,
      'nombre': nombre,
    };
    try {
      var response = await client.put(Uri.parse('${apiUrl}etiqueta/'),
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

  static Future<int> eliminarEtiqueta(
      {required int idEtiqueta,
      required String token}) async {
    final client = Client();
    final body = {
      "idEtiqueta": idEtiqueta,
    };
    try {
      var response = await client.delete(Uri.parse('${apiUrl}etiqueta/'),
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
