import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import 'components/dropdowncategorias.component.dart';
import 'components/dropdownprioridades.component.dart';

class CrearTareaScreen extends StatefulWidget {
  const CrearTareaScreen({Key? key}) : super(key: key);

  @override
  State<CrearTareaScreen> createState() => _CrearTareaScreenState();
}

class _CrearTareaScreenState extends State<CrearTareaScreen> {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();
  ValidacionesTextField checkdescripcion = ValidacionesTextField();
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
            texto: 'Crear tarea',
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
                  dropDownCategorias(categoriaprovider.listCategorias,
                      categoriaprovider, context),
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
                          .crearTarea(context,
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
                          // controller.traerCategorias(context).then((value) {
                          //   Navigator.pop(context);
                          // });
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
