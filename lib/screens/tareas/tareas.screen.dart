import 'package:app_tareas/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../screens.dart';

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
    return Scaffold(
        // backgroundColor: tema.background,
        appBar: AppBar(
          title: const TextSecundario(texto: 'Tareas'),
          actions: [
            IconButton(
                onPressed: () {
                  CategoriaController(categoriaProvider: categoriaprovider)
                      .traerCategorias(context);
                  PrioridadController(prioridadProvider: prioridadprovider)
                      .traerPrioridades(context);
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
              separatorBuilder: ((context, index) => const Divider()),
              itemCount: categoriaprovider.listCategorias.length,
              itemBuilder: (context, i) => ItemTarea(
                    categoria: categoriaprovider.listCategorias[i],
                    tema: tema,
                    size: size,
                  )),
        ));
  }
}

class ItemTarea extends StatelessWidget {
  const ItemTarea({
    Key? key,
    required this.categoria,
    required this.tema,
    required this.size,
  }) : super(key: key);

  final Categoria categoria;
  final ColorScheme tema;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ActualizarCategoriaScreen(
                      categoria: categoria,
                    )));
      },
      child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextSecundario(texto: categoria.nombre ?? ''),
              TextParrafo(texto: categoria.descripcion ?? '')
            ],
          )),
    );
  }
}
