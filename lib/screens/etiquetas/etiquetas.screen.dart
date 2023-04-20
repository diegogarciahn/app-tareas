import 'package:app_tareas/screens/actualizaretiqueta/actualizaretiqueta.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../screens.dart';

class EtiquetasScreen extends StatefulWidget {
  const EtiquetasScreen({Key? key}) : super(key: key);

  @override
  State<EtiquetasScreen> createState() => _EtiquetasScreenState();
}

class _EtiquetasScreenState extends State<EtiquetasScreen> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final etiquetaprovider = Provider.of<EtiquetaProvider>(context);
    return Scaffold(
        // backgroundColor: tema.background,
        appBar: AppBar(
          title: const TextSecundario(texto: 'Etiquetas'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CrearEtiquetaScreen()));
                },
                icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.separated(
              separatorBuilder: ((context, index) => const Divider()),
              itemCount: etiquetaprovider.listEtiquetas.length,
              itemBuilder: (context, i) => ItemEtiqueta(
                    etiqueta: etiquetaprovider.listEtiquetas[i],
                    tema: tema,
                    size: size,
                  )),
        ));
  }
}

class ItemEtiqueta extends StatelessWidget {
  const ItemEtiqueta({
    Key? key,
    required this.etiqueta,
    required this.tema,
    required this.size,
  }) : super(key: key);

  final Etiqueta etiqueta;
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
                builder: (_) => ActualizarEtiquetaScreen(
                      etiqueta: etiqueta,
                    )));
      },
      child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextSecundario(texto: etiqueta.nombre ?? ''),
            ],
          )),
    );
  }
}
