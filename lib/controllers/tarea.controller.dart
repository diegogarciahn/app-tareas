import 'package:app_tareas/providers/providers.dart';
import 'package:app_tareas/services/services.dart';
import 'package:flutter/material.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';

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
}
