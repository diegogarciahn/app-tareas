import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';

class CrearPrioridadScreen extends StatefulWidget {
  const CrearPrioridadScreen({Key? key}) : super(key: key);

  @override
  State<CrearPrioridadScreen> createState() => _CrearPrioridadScreenState();
}

class _CrearPrioridadScreenState extends State<CrearPrioridadScreen> {
  TextEditingController etiquetaController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();

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
            texto: 'Crear prioridad',
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
                          .crearPrioridad(context,
                              nombre: etiquetaController.text)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Prioridad creada exitosamente',
                              color: Colors.green);
                          controller.traerPrioridades(context).then((value) {
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
        if (prioridadprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
