import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
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
    final categoriaprovider = Provider.of<CategoriaProvider>(context);
    return Stack(
      children: [
        Scaffold(
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
              padding: const EdgeInsets.only(top: 8),
              child: ListView.separated(
                  separatorBuilder: ((context, index) => const Divider()),
                  itemCount: categoriaprovider.listCategorias.length,
                  itemBuilder: (context, i) => ItemCategoria(
                        categoria: categoriaprovider.listCategorias[i],
                        tema: tema,
                        size: size,
                      )),
            )),
        if (categoriaprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}

class ItemCategoria extends StatelessWidget {
  const ItemCategoria({
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
