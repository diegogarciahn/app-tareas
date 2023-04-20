import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class ActualizarCategoriaScreen extends StatefulWidget {
  const ActualizarCategoriaScreen({Key? key, required this.categoria})
      : super(key: key);

  final Categoria categoria;

  @override
  State<ActualizarCategoriaScreen> createState() =>
      _ActualizarCategoriaScreenState();
}

class _ActualizarCategoriaScreenState extends State<ActualizarCategoriaScreen> {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();
  ValidacionesTextField checkdescripcion = ValidacionesTextField();

  @override
  void initState() {
    categoriaController.text = widget.categoria.nombre ?? '';
    descripcionController.text = widget.categoria.descripcion ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    final categoriaprovider = Provider.of<CategoriaProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          appBar: AppBar(
              title: const TextSecundario(
            texto: 'Actualizar categoría',
          )),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              decoration: BoxDecoration(color: tema.surface),
              child: Column(
                children: [
                  TextField(
                    controller: categoriaController,
                    onChanged: (value) {
                      check.isEmpty(categoriaController);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        errorText: check.error ? check.errorText : null,
                        errorMaxLines: 4,
                        border: const OutlineInputBorder(),
                        hintText: 'Ej. Categoría',
                        label: const TextParrafo(texto: 'Nombre de categoría')),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descripcionController,
                    onChanged: (value) {
                      checkdescripcion.isEmpty(categoriaController);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        errorText: checkdescripcion.error
                            ? checkdescripcion.errorText
                            : null,
                        errorMaxLines: 4,
                        border: const OutlineInputBorder(),
                        hintText: 'Ej. Esto es una descripción',
                        label: const TextParrafo(texto: 'Descripción')),
                  ),
                  ButtonXXL(
                    funcion: () {
                      check.isEmpty(categoriaController);
                      checkdescripcion.isEmpty(descripcionController);
                      setState(() {});

                      if (check.error || checkdescripcion.error) {
                        return alertError(context,
                            mensaje: 'Por favor complete todos los campos');
                      }
                      final controller = CategoriaController(
                          categoriaProvider: categoriaprovider);
                      controller
                          .actualizarCategoria(context,
                              idCategoria: widget.categoria.id ?? 0,
                              nombreCategoria: categoriaController.text,
                              descripcion: descripcionController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Categoría actualizada exitosamente',
                              color: Colors.green);
                          controller.traerCategorias(context).then((value) {
                            Navigator.pop(context);
                          });
                        }
                      });
                    },
                    texto: 'Actualizar',
                    sinMargen: true,
                  ),
                  ButtonXXL(
                    funcion: () {
                      final controller = CategoriaController(
                          categoriaProvider: categoriaprovider);
                      dialogDecision('Eliminar categoría',
                          '¿Está seguro de eliminar esta categoría?', () {
                        Navigator.pop(context);
                        controller
                            .eliminarCategoria(context,
                                idCategoria: widget.categoria.id ?? 0)
                            .then((value) {
                          if (value) {
                            globalSnackBar('Categoría actualizada exitosamente',
                                color: Colors.green);
                            controller.traerCategorias(context).then((value) {
                              Navigator.pop(context);
                            });
                          }
                        });
                      }, () => Navigator.pop(context), context);
                    },
                    texto: 'Eliminar',
                    colorFondo: tema.error,
                    colorTexto: tema.onPrimary,
                    sinMargen: true,
                  )
                ],
              ),
            ),
          ]),
        ),
        if (categoriaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
