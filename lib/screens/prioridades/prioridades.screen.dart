import 'package:app_tareas/screens/actualizarprioridad/actualizarprioridad.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../screens.dart';

class PrioridadesScreen extends StatefulWidget {
  const PrioridadesScreen({Key? key}) : super(key: key);

  @override
  State<PrioridadesScreen> createState() => _PrioridadesScreenState();
}

class _PrioridadesScreenState extends State<PrioridadesScreen> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final prioridadprovider = Provider.of<PrioridadProvider>(context);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const TextSecundario(texto: 'Prioridades'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CrearPrioridadScreen()));
                    },
                    icon: const Icon(Icons.add_circle_outline))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                  separatorBuilder: ((context, index) => const Divider()),
                  itemCount: prioridadprovider.listPrioridades.length,
                  itemBuilder: (context, i) => ItemPrioridad(
                        prioridad: prioridadprovider.listPrioridades[i],
                        tema: tema,
                        size: size,
                      )),
            )),
        if (prioridadprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}

class ItemPrioridad extends StatelessWidget {
  const ItemPrioridad({
    Key? key,
    required this.prioridad,
    required this.tema,
    required this.size,
  }) : super(key: key);

  final Prioridad prioridad;
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
                builder: (_) => ActualizarPrioridadScreen(
                      prioridad: prioridad,
                    )));
      },
      child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextSecundario(texto: prioridad.nombre ?? ''),
            ],
          )),
    );
  }
}
