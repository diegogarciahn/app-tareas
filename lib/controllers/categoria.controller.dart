import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class CategoriaController {
  CategoriaProvider categoriaProvider;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  CategoriaController({required this.categoriaProvider});

  Future<bool> crearCategoria(
    context, {
    required String nombreCategoria,
    required String descripcion,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      categoriaProvider.loading = true;
      final respuesta = await CategoriaService.crearCategoria(
          nombreCategoria: nombreCategoria,
          descripcion: descripcion,
          token: token);
      if (respuesta == 200) {
        categoriaProvider.loading = false;
        globalSnackBar('Producto creado exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'crear el producto',
          codRespuesta: respuesta, funcionFinal: () {
        categoriaProvider.loading = false;
        return false;
      });
    }
    categoriaProvider.loading = false;
    return false;
  }

  Future<bool> traerCategorias(context) async {
    final token = await traerToken(context);
    if (token != '') {
      categoriaProvider.loading = true;
      final respuesta = await CategoriaService.traerCategorias(token);
      if (respuesta is List<Categoria>) {
        categoriaProvider.listCategorias = respuesta;
        categoriaProvider.loading = false;
        return true;
      }
      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'traer las categorías ',
          funcion404: () => alertError(context,
              mensaje: 'No se encontraron categorías para mostrar'),
          codRespuesta: respuesta);
      categoriaProvider.listCategorias = [];
      categoriaProvider.loading = false;
    }
    return false;
  }

  Future<bool> actualizarCategoria(
    context, {
    required int idCategoria,
    required String nombreCategoria,
    required String descripcion,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      categoriaProvider.loading = true;
      final respuesta = await CategoriaService.actualizarCategoria(
          idCategoria: idCategoria,
          nombreCategoria: nombreCategoria,
          descripcion: descripcion,
          token: token);
      if (respuesta == 200) {
        categoriaProvider.loading = false;
        globalSnackBar('Producto actualizado exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'actualizar la categoría',
          codRespuesta: respuesta, funcionFinal: () {
        categoriaProvider.loading = false;
        return false;
      });
    }
    categoriaProvider.loading = false;
    return false;
  }

  Future<bool> eliminarCategoria(
    context, {
    required int idCategoria,
  }) async {
    final token = await traerToken(context);
    if (token != '') {
      categoriaProvider.loading = true;
      final respuesta = await CategoriaService.eliminarCategoria(
          idCategoria: idCategoria, token: token);
      if (respuesta == 200) {
        categoriaProvider.loading = false;
        globalSnackBar('Producto eliminado exitósamente', color: Colors.green);
        return true;
      }

      CuerpoDeController.cuerpoNormal(context,
          mensajeError: 'eliminar la categoría',
          codRespuesta: respuesta, funcionFinal: () {
        categoriaProvider.loading = false;
        return false;
      });
    }
    categoriaProvider.loading = false;
    return false;
  }
}
