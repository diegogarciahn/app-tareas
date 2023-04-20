import 'package:flutter/material.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class TareaController {
  TareaProvider tareaProvider;

  TareaController({required this.tareaProvider});

  Future<bool> crearTarea(
    context, {
    required String titulo,
    required String descripcion,
    required int idCategoria,
    required int idPrioridad,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      tareaProvider.loading = true;
      final respuesta = await TareaService.crearTarea(
          titulo: titulo,
          descripcion: descripcion,
          idCategoria: idCategoria,
          idPrioridad: idPrioridad,
          token: token);
      if (respuesta == 201) {
        tareaProvider.loading = false;
        globalSnackBar('Tarea creada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'crear la tarea',
          codRespuesta: respuesta, funcionFinal: () {
        tareaProvider.loading = false;
        return false;
      });
    }
    tareaProvider.loading = false;
    return false;
  }

  Future<bool> traerTareas(context) async {
    final token = await traerToken(context);
    if (token != '') {
      tareaProvider.loading = true;
      final respuesta = await TareaService.traerTareas(token);
      if (respuesta is List<Tarea>) {
        tareaProvider.listTareas = respuesta;
        tareaProvider.loading = false;
        return true;
      }
      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'traer las tareas ',
          funcion404: () => alertError(context,
              mensaje: 'No se encontraron tareas para mostrar'),
          codRespuesta: respuesta);
      tareaProvider.listTareas = [];
      tareaProvider.loading = false;
    }
    return false;
  }

  Future<bool> actualizarTarea(
    context, {
    required int idTarea,
    required String titulo,
    required String descripcion,
    required String estado,
    required int idCategoria,
    required int idPrioridad,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      tareaProvider.loading = true;
      final respuesta = await TareaService.actualizarTarea(
          idTarea: idTarea,
          titulo: titulo,
          descripcion: descripcion,
          estado: estado,
          idCategoria: idCategoria,
          idPrioridad: idPrioridad,
          token: token);
      if (respuesta == 200) {
        tareaProvider.loading = false;
        globalSnackBar('Tarea actualizada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'actualizar la tarea',
          codRespuesta: respuesta, funcionFinal: () {
        tareaProvider.loading = false;
        return false;
      });
    }
    tareaProvider.loading = false;
    return false;
  }

  Future<bool> eliminarTarea(
    context, {
    required int idTarea,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      tareaProvider.loading = true;
      final respuesta = await TareaService.eliminarTarea(
          idTarea: idTarea, token: token);
      if (respuesta == 200) {
        tareaProvider.loading = false;
        globalSnackBar('Tarea eliminada exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'eliminar la tarea',
          codRespuesta: respuesta, funcionFinal: () {
        tareaProvider.loading = false;
        return false;
      });
    }
    tareaProvider.loading = false;
    return false;
  }
}
