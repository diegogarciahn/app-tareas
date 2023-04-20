import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final categoriasprovider = Provider.of<CategoriaProvider>(context);
    final etiquetasprovider = Provider.of<EtiquetaProvider>(context);
    final prioridadprovider = Provider.of<PrioridadProvider>(context);
    return Scaffold(
      backgroundColor: tema.background,
      appBar: AppBar(
          backgroundColor: tema.surface,
          centerTitle: true,
          elevation: 0,
          title: TextSecundario(
            texto: 'Bienvenido ¿Qué deseas hacer hoy?',
            colorTexto: tema.secondary,
          )),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.toc_rounded,
                      labelText: 'Tareas',
                      funcion: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TareasScreen()));
                      })),
              SizedBox(width: size.width * 0.02),
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.topic_outlined,
                      labelText: 'Categorías',
                      funcion: () {
                        CategoriaController(
                                categoriaProvider: categoriasprovider)
                            .traerCategorias(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CategoriasScreen()));
                      })),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.label_outline,
                      labelText: 'Etiquetas',
                      funcion: () {
                        EtiquetaController(etiquetaProvider: etiquetasprovider)
                            .traerEtiquetas(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EtiquetasScreen()));
                      })),
              SizedBox(width: size.width * 0.02),
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.warning_amber_rounded,
                      labelText: 'Prioridades de tareas',
                      funcion: () {
                        PrioridadController(
                                prioridadProvider: prioridadprovider)
                            .traerPrioridades(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrioridadesScreen()));
                      })),
            ],
          ),
        )
      ]),
    );
  }
}
