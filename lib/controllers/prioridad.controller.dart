import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class PrioridadController {
  PrioridadProvider prioridadProvider;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  PrioridadController({required this.prioridadProvider});

  Future<bool> crearPrioridad(
    context, {
    required String nombre,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      prioridadProvider.loading = true;
      final respuesta =
          await PrioridadService.crearPrioridad(nombre: nombre, token: token);
      if (respuesta == 200) {
        prioridadProvider.loading = false;
        globalSnackBar('Prioridad creada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'crear la prioridad',
          codRespuesta: respuesta, funcionFinal: () {
        prioridadProvider.loading = false;
        return false;
      });
    }
    prioridadProvider.loading = false;
    return false;
  }

  Future<bool> traerPrioridades(context) async {
    final token = await traerToken(context);
    if (token != '') {
      prioridadProvider.loading = true;
      final respuesta = await PrioridadService.traerPrioridads(token);
      if (respuesta is List<Prioridad>) {
        prioridadProvider.listPrioridades = respuesta;
        prioridadProvider.loading = false;
        return true;
      }
      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'traer las prioridades',
          funcion404: () => alertError(context,
              mensaje: 'No se encontraron prioridades para mostrar'),
          codRespuesta: respuesta);
      prioridadProvider.listPrioridades = [];
      prioridadProvider.loading = false;
    }
    return false;
  }

  Future<bool> actualizarPrioridad(
    context, {
    required int idPrioridad,
    required String nombre,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      prioridadProvider.loading = true;
      final respuesta = await PrioridadService.actualizarPrioridad(
          idPrioridad: idPrioridad, nombre: nombre, token: token);
      if (respuesta == 200) {
        prioridadProvider.loading = false;
        globalSnackBar('Prioridad actualizada exitósamente',
            color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'actualizar la prioridad',
          codRespuesta: respuesta, funcionFinal: () {
        prioridadProvider.loading = false;
        return false;
      });
    }
    prioridadProvider.loading = false;
    return false;
  }

  Future<bool> eliminarPrioridad(
    context, {
    required int idPrioridad,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      prioridadProvider.loading = true;
      final respuesta = await PrioridadService.eliminarPrioridad(
          idPrioridad: idPrioridad, token: token);
      if (respuesta == 200) {
        prioridadProvider.loading = false;
        globalSnackBar('Prioridad eliminada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'eliminar la prioridad',
          codRespuesta: respuesta, funcionFinal: () {
        prioridadProvider.loading = false;
        return false;
      });
    }
    prioridadProvider.loading = false;
    return false;
  }
}
