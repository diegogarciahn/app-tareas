import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class EtiquetaController {
  EtiquetaProvider etiquetaProvider;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  EtiquetaController({required this.etiquetaProvider});

  Future<bool> crearEtiqueta(
    context, {
    required String nombre,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      etiquetaProvider.loading = true;
      final respuesta =
          await EtiquetaService.crearEtiqueta(nombre: nombre, token: token);
      if (respuesta == 200) {
        etiquetaProvider.loading = false;
        globalSnackBar('Etiqueta creada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'crear la etiqueta',
          codRespuesta: respuesta, funcionFinal: () {
        etiquetaProvider.loading = false;
        return false;
      });
    }
    etiquetaProvider.loading = false;
    return false;
  }

  Future<bool> traerEtiquetas(context) async {
    final token = await traerToken(context);
    if (token != '') {
      etiquetaProvider.loading = true;
      final respuesta = await EtiquetaService.traerEtiquetas(token);
      if (respuesta is List<Etiqueta>) {
        etiquetaProvider.listEtiquetas = respuesta;
        etiquetaProvider.loading = false;
        return true;
      }
      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'traer las etiquetas ',
          funcion404: () => alertError(context,
              mensaje: 'No se encontraron etiquetas para mostrar'),
          codRespuesta: respuesta);
      etiquetaProvider.listEtiquetas = [];
      etiquetaProvider.loading = false;
    }
    return false;
  }

  Future<bool> actualizarEtiqueta(
    context, {
    required int idEtiqueta,
    required String nombre,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      etiquetaProvider.loading = true;
      final respuesta = await EtiquetaService.actualizarEtiqueta(
          idEtiqueta: idEtiqueta, nombre: nombre, token: token);
      if (respuesta == 200) {
        etiquetaProvider.loading = false;
        globalSnackBar('Etiqueta actualizada exitósamente',
            color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'actualizar la etiqueta',
          codRespuesta: respuesta, funcionFinal: () {
        etiquetaProvider.loading = false;
        return false;
      });
    }
    etiquetaProvider.loading = false;
    return false;
  }

  Future<bool> eliminarEtiqueta(
    context, {
    required int idEtiqueta,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      etiquetaProvider.loading = true;
      final respuesta = await EtiquetaService.eliminarEtiqueta(
          idEtiqueta: idEtiqueta, token: token);
      if (respuesta == 200) {
        etiquetaProvider.loading = false;
        globalSnackBar('Etiqueta eliminada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'eliminar la etiqueta',
          codRespuesta: respuesta, funcionFinal: () {
        etiquetaProvider.loading = false;
        return false;
      });
    }
    etiquetaProvider.loading = false;
    return false;
  }
}
