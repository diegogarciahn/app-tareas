import 'package:app_tareas/controllers/controllers.dart';
import 'package:app_tareas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';

class ActualizarEtiquetaScreen extends StatefulWidget {
  const ActualizarEtiquetaScreen({Key? key, required this.etiqueta})
      : super(key: key);

  final Etiqueta etiqueta;

  @override
  State<ActualizarEtiquetaScreen> createState() =>
      _ActualizarEtiquetaScreenState();
}

class _ActualizarEtiquetaScreenState extends State<ActualizarEtiquetaScreen> {
  TextEditingController etiquetaController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();

  @override
  void initState() {
    etiquetaController.text = widget.etiqueta.nombre ?? '';
    super.initState();
  }

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
            texto: 'Actualizar etiqueta',
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
                          .actualizarEtiqueta(context,
                              idEtiqueta: widget.etiqueta.id ?? 0,
                              nombre: etiquetaController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Etiqueta actualizada exitosamente',
                              color: Colors.green);
                          controller.traerEtiquetas(context).then((value) {
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
                      final controller = EtiquetaController(
                          etiquetaProvider: etiquetaprovider);
                      dialogDecision('Eliminar etiqueta',
                          '¿Está seguro de eliminar esta etiqueta?', () {
                        Navigator.pop(context);
                        controller
                            .eliminarEtiqueta(context,
                                idEtiqueta: widget.etiqueta.id ?? 0)
                            .then((value) {
                          if (value) {
                            globalSnackBar('Etiqueta eliminada exitosamente',
                                color: Colors.green);
                            controller.traerEtiquetas(context).then((value) {
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
        if (etiquetaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
