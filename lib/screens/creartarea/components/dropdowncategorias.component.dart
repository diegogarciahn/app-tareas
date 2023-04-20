import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

List<DropdownMenuItem<int>> listaItem(List<Categoria> categorias) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < categorias.length; i++) {
    lista.add(DropdownMenuItem(
      value: categorias[i].id,
      child: Text(categorias[i].nombre ?? ''),
    ));
  }

  return lista;
}

String buscarNombre(List<Categoria> listCategorias, int idSeleccionado) {
  for (var categoria in listCategorias) {
    if (categoria.id == idSeleccionado) {
      return categoria.nombre ?? '';
    }
  }
  return '';
}

Widget dropDownCategorias(List<Categoria> listCategorias,
    CategoriaProvider categoriaProvider, context) {
  List<DropdownMenuItem<int>> listItemDropDrown = listaItem(listCategorias);

  Size size = MediaQuery.of(context).size;
  final tema = Theme.of(context).colorScheme;

  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    decoration: BoxDecoration(
        color: tema.surface,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(width: 0.2, color: tema.onSurfaceVariant)),
    child: Row(
      children: [
        if (categoriaProvider.idCategoriaSelected != 0)
          const Icon(Icons.check, color: Colors.green),
        SizedBox(
          width: size.width * 0.02,
        ),
        Expanded(
          child: DropdownButton(
              isExpanded: true,
              hint: Text(categoriaProvider.nombreCategoriaSelected,
                  style: GoogleFonts.sourceSansPro()),
              items: listItemDropDrown,
              underline: const SizedBox(),
              onChanged: (int? value) {
                categoriaProvider.idCategoriaSelected = value!;
                categoriaProvider.nombreCategoriaSelected =
                    buscarNombre(listCategorias, value);
              }),
        ),
      ],
    ),
  );
}
