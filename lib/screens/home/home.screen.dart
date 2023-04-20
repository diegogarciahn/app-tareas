import 'package:flutter/material.dart';

import '../../globals/widgets/widgets.dart';
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
                      funcion: () {})),
              SizedBox(width: size.width * 0.02),
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.topic_outlined,
                      labelText: 'Categorías',
                      funcion: () {
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
                      icono: Icons.add,
                      labelText: 'Categorías',
                      funcion: () {})),
              SizedBox(width: size.width * 0.02),
              Expanded(
                  child: GridItemHome(
                      size: size,
                      icono: Icons.add,
                      labelText: 'Categorías',
                      funcion: () {})),
            ],
          ),
        )
      ]),
    );
  }
}
