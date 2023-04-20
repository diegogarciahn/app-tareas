import 'package:flutter/material.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class ComentarioController {
  ComentarioProvider comentarioProvider;

  ComentarioController({required this.comentarioProvider});

  Future<bool> crearComentario(
    context, {
    required String contenido,
    required int idTarea,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      comentarioProvider.loading = true;
      final respuesta = await ComentarioService.crearComentario(
          contenido: contenido, idTarea: idTarea, token: token);
      if (respuesta == 201) {
        comentarioProvider.loading = false;
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'crear el comentario',
          codRespuesta: respuesta, funcionFinal: () {
        comentarioProvider.loading = false;
        return false;
      });
    }
    comentarioProvider.loading = false;
    return false;
  }

  Future<bool> traerComentarios(context, {required int idTarea}) async {
    final token = await traerToken(context);
    if (token != '') {
      comentarioProvider.loading = true;
      final respuesta = await ComentarioService.traerComentarios(
          token: token, idTarea: idTarea);
      if (respuesta is List<Comentario>) {
        comentarioProvider.listComentarios = respuesta;
        comentarioProvider.loading = false;
        return true;
      }
      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'traer los comentarios ',
          funcion404: () => alertError(context,
              mensaje: 'No se encontraron comentarios para mostrar'),
          codRespuesta: respuesta);
      comentarioProvider.listComentarios = [];
      comentarioProvider.loading = false;
    }
    return false;
  }

  Future<bool> eliminarComentario(
    context, {
    required int idComentario,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      comentarioProvider.loading = true;
      final respuesta = await ComentarioService.eliminarComentario(
          idComentario: idComentario, token: token);
      if (respuesta == 200) {
        comentarioProvider.loading = false;
        globalSnackBar('Comentario eliminado exitósamente',
            color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'eliminar el comentario',
          codRespuesta: respuesta, funcionFinal: () {
        comentarioProvider.loading = false;
        return false;
      });
    }
    comentarioProvider.loading = false;
    return false;
  }
}
