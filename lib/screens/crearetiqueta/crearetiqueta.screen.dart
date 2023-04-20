import 'package:app_tareas/controllers/categoria.controller.dart';
import 'package:app_tareas/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';

class CrearEtiquetaScreen extends StatefulWidget {
  const CrearEtiquetaScreen({Key? key}) : super(key: key);

  @override
  State<CrearEtiquetaScreen> createState() => _CrearEtiquetaScreenState();
}

class _CrearEtiquetaScreenState extends State<CrearEtiquetaScreen> {
  TextEditingController etiquetaController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    final etiquetaprovider = Provider.of<EtiquetaProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          appBar: AppBar(
              title: const TextSecundario(
            texto: 'Crear etiqueta',
          )),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: tema.surface),
              child: Column(
                children: [
                  TextField(
                    controller: etiquetaController,
                    onChanged: (value) {
                      check.isEmpty(etiquetaController);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        errorText: check.error ? check.errorText : null,
                        errorMaxLines: 4,
                        border: const OutlineInputBorder(),
                        hintText: 'Ej. Etiqueta 1',
                        label: const TextParrafo(texto: 'Nombre de etiqueta')),
                  ),
                  const SizedBox(height: 10),
                  ButtonXXL(
                    funcion: () {
                      check.isEmpty(etiquetaController);
                      setState(() {});

                      if (check.error) {
                        return alertError(context,
                            mensaje: 'Por favor complete todos los campos');
                      }

                      final controller = EtiquetaController(
                          etiquetaProvider: etiquetaprovider);
                      controller
                          .crearEtiqueta(context,
                              nombre: etiquetaController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Categoría creada exitosamente',
                              color: Colors.green);
                          controller.traerEtiquetas(context).then((value) {
                            Navigator.pop(context);
                          });
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
        if (etiquetaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
