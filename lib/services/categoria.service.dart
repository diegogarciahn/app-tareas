import 'dart:convert';

import 'package:app_tareas/models/models.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../globals/functions/functions.dart';

class CategoriaService {
  static Future<int> crearCategoria(
      {required String nombreCategoria,
      required String descripcion,
      required String token}) async {
    final client = Client();
    final body = {
      "nombre": nombreCategoria,
      "descripcion": descripcion,
    };
    try {
      var response = await client.post(Uri.parse('${apiUrl}categoria/'),
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

  static Future traerCategorias(String token) async {
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

  static Future<int> actualizarCategoria(
      {required int idCategoria,
      required String nombreCategoria,
      required String descripcion,
      required String token}) async {
    final client = Client();
    final body = {
      "idCategoria": idCategoria,
      "nombre": nombreCategoria,
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

  static Future<int> eliminarCategoria(
      {required int idCategoria,
      required String token}) async {
    final client = Client();
    final body = {
      "idCategoria": idCategoria,
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
