import 'package:flutter/material.dart';

import '../../globals/widgets/widgets.dart';
import '../screens.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: tema.background,
        appBar: AppBar(
          title: const TextSecundario(texto: 'Categorías'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CrearCategoriaScreen()));
                },
                icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
        ));
  }
}
