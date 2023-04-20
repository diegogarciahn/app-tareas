import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../creartarea/components/dropdowncategorias.component.dart';
import '../creartarea/components/dropdownprioridades.component.dart';

class ActualizarTareaScreen extends StatefulWidget {
  const ActualizarTareaScreen({Key? key, required this.tarea})
      : super(key: key);

  final Tarea tarea;

  @override
  State<ActualizarTareaScreen> createState() => _ActualizarTareaScreenState();
}

class _ActualizarTareaScreenState extends State<ActualizarTareaScreen> {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();
  ValidacionesTextField checkdescripcion = ValidacionesTextField();

  @override
  void initState() {
    categoriaController.text = widget.tarea.titulo ?? '';
    descripcionController.text = widget.tarea.descripcion ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    final categoriaprovider = Provider.of<CategoriaProvider>(context);
    final prioridadprovider = Provider.of<PrioridadProvider>(context);
    final tareaprovider = Provider.of<TareaProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          appBar: AppBar(
              title: const TextSecundario(
            texto: 'Actualizar tarea',
          )),
          body: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: tema.surface),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        hintText: 'Ej. Leer libro',
                        label: const TextParrafo(texto: 'Nombre de tarea')),
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
                        label: const TextParrafo(
                            texto: 'Descripción de la tarea')),
                  ),
                  const SizedBox(height: 10),
                  const TextParrafo(texto: 'Categoría:'),
                  dropDownCategorias(categoriaprovider.listCategorias,
                      categoriaprovider, context),
                  const SizedBox(height: 10),
                  const TextParrafo(texto: 'Prioridad:'),
                  dropDownPrioridades(prioridadprovider.listPrioridades,
                      prioridadprovider, context),
                  ButtonXXL(
                    funcion: () {
                      check.isEmpty(categoriaController);
                      checkdescripcion.isEmpty(descripcionController);
                      setState(() {});

                      if (check.error ||
                          checkdescripcion.error ||
                          categoriaprovider.idCategoriaSelected == 0 ||
                          prioridadprovider.idPrioridadSelected == 0) {
                        return alertError(context,
                            mensaje: 'Por favor complete todos los campos');
                      }

                      final controller =
                          TareaController(tareaProvider: tareaprovider);
                      controller
                          .actualizarTarea(context,
                              idTarea: widget.tarea.id ?? 0,
                              estado: 'en_progreso',
                              titulo: categoriaController.text,
                              descripcion: descripcionController.text,
                              idCategoria:
                                  categoriaprovider.idCategoriaSelected,
                              idPrioridad:
                                  prioridadprovider.idPrioridadSelected)
                          .then((value) {
                        if (value) {
                          globalSnackBar('Tarea creada exitosamente',
                              color: Colors.green);
                          controller.traerTareas(context).then((value) {
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
                      final controller =
                          TareaController(tareaProvider: tareaprovider);
                      dialogDecision('Eliminar tarea',
                          '¿Está seguro de eliminar esta tarea?', () {
                        Navigator.pop(context);
                        controller
                            .eliminarTarea(context,
                                idTarea: widget.tarea.id ?? 0)
                            .then((value) {
                          if (value) {
                            globalSnackBar('Tarea eliminada exitosamente',
                                color: Colors.green);
                            controller.traerTareas(context).then((value) {
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
        if (tareaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
