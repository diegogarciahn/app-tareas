import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import '../screens.dart';
import 'components/itemtarea.component.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({Key? key}) : super(key: key);

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final categoriaprovider = Provider.of<CategoriaProvider>(context);
    final prioridadprovider = Provider.of<PrioridadProvider>(context);
    final tareaprovider = Provider.of<TareaProvider>(context);
    return Stack(
      children: [
        Scaffold(
            backgroundColor: tema.background,
            appBar: AppBar(
              title: const TextSecundario(texto: 'Tareas'),
              actions: [
                IconButton(
                    onPressed: () {
                      CategoriaController(categoriaProvider: categoriaprovider)
                          .traerCategorias(context);
                      PrioridadController(prioridadProvider: prioridadprovider)
                          .traerPrioridades(context);
                      categoriaprovider.idCategoriaSelected = 0;
                      categoriaprovider.nombreCategoriaSelected = "Seleccione una categoría";
                      prioridadprovider.idPrioridadSelected = 0;
                      prioridadprovider.prioridadSelected = "Seleccione un nivel de prioridad";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CrearTareaScreen()));
                    },
                    icon: const Icon(Icons.add_circle_outline))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                  separatorBuilder: ((context, index) => const Divider(
                        height: 8,
                        color: Colors.transparent,
                      )),
                  itemCount: tareaprovider.listTareas.length,
                  itemBuilder: (context, i) => ItemTarea(
                        tarea: tareaprovider.listTareas[i],
                        tema: tema,
                        size: size,
                      )),
            )),
        if (tareaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}
