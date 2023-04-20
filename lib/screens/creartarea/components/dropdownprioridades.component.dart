import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

List<DropdownMenuItem<int>> listaItem(List<Prioridad> prioridades) {
  List<DropdownMenuItem<int>> lista = [];
  for (var i = 0; i < prioridades.length; i++) {
    lista.add(DropdownMenuItem(
      value: prioridades[i].id,
      child: Text(prioridades[i].nombre ?? ''),
    ));
  }

  return lista;
}

String buscarNombre(List<Prioridad> listPrioridades, int idSeleccionado) {
  for (var prioridad in listPrioridades) {
    if (prioridad.id == idSeleccionado) {
      return prioridad.nombre ?? '';
    }
  }
  return '';
}

Widget dropDownPrioridades(List<Prioridad> listCategorias,
    PrioridadProvider prioridadProvider, context) {
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
        if (prioridadProvider.idPrioridadSelected != 0)
          const Icon(Icons.check, color: Colors.green),
        SizedBox(
          width: size.width * 0.02,
        ),
        Expanded(
          child: DropdownButton(
              isExpanded: true,
              hint: Text(prioridadProvider.prioridadSelected,
                  style: GoogleFonts.sourceSansPro()),
              items: listItemDropDrown,
              underline: const SizedBox(),
              onChanged: (int? value) {
                prioridadProvider.idPrioridadSelected = value!;
                prioridadProvider.prioridadSelected =
                    buscarNombre(listCategorias, value);
              }),
        ),
      ],
    ),
  );
}
