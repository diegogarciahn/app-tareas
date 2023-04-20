import 'package:app_tareas/controllers/categoria.controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';

class CrearCategoriaScreen extends StatefulWidget {
  const CrearCategoriaScreen({Key? key}) : super(key: key);

  @override
  State<CrearCategoriaScreen> createState() => _CrearCategoriaScreenState();
}

class _CrearCategoriaScreenState extends State<CrearCategoriaScreen> {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();
  ValidacionesTextField checkdescripcion = ValidacionesTextField();
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
            texto: 'Crear categoría',
          )),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: tema.surface),
              child: Column(
                children: [
                  TextField(
                    controller: categoriaController,
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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

                      CategoriaController(categoriaProvider: categoriaprovider)
                          .crearCategoria(context,
                              nombreCategoria: categoriaController.text,
                              descripcion: descripcionController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Categoría creada exitosamente');
                          Navigator.pop(context);
                        }
                      });
                    },
                    texto: 'Crear',
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
