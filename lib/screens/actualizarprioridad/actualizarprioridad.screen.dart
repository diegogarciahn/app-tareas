import 'package:app_tareas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';

class ActualizarPrioridadScreen extends StatefulWidget {
  const ActualizarPrioridadScreen({Key? key, required this.prioridad})
      : super(key: key);

  final Prioridad prioridad;

  @override
  State<ActualizarPrioridadScreen> createState() =>
      _ActualizarPrioridadScreenState();
}

class _ActualizarPrioridadScreenState extends State<ActualizarPrioridadScreen> {
  TextEditingController etiquetaController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();

  @override
  void initState() {
    etiquetaController.text = widget.prioridad.nombre ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    final prioridadprovider = Provider.of<PrioridadProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          appBar: AppBar(
              title: const TextSecundario(
            texto: 'Actualizar prioridad',
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
                        hintText: 'Ej. Prioridad 1',
                        label: const TextParrafo(texto: 'Nombre de prioridad')),
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

                      final controller = PrioridadController(
                          prioridadProvider: prioridadprovider);
                      controller
                          .actualizarPrioridad(context,
                              idPrioridad: widget.prioridad.id ?? 0,
                              nombre: etiquetaController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Prioridad actualizada exitosamente',
                              color: Colors.green);
                          controller.traerPrioridades(context).then((value) {
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
                      final controller = PrioridadController(
                          prioridadProvider: prioridadprovider);
                      dialogDecision('Eliminar prioridad',
                          '¿Está seguro de eliminar esta propiedad?', () {
                        Navigator.pop(context);
                        controller
                            .eliminarPrioridad(context,
                                idPrioridad: widget.prioridad.id ?? 0)
                            .then((value) {
                          if (value) {
                            globalSnackBar('Prioridad eliminada exitosamente',
                                color: Colors.green);
                            controller.traerPrioridades(context).then((value) {
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
        if (prioridadprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
