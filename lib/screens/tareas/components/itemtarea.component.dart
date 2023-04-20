import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../screens.dart';
import 'buttontarea.component.dart';
import 'dialogestados.component.dart';
import 'labelitemtarea.component.dart';

class ItemTarea extends StatelessWidget {
  const ItemTarea({
    Key? key,
    required this.tarea,
    required this.tema,
    required this.size,
  }) : super(key: key);

  final Tarea tarea;
  final ColorScheme tema;
  final Size size;

  String getNameStatus(String? estado) {
    switch (estado) {
      case 'pendiente':
        return 'Pendiente';
      case 'en_progreso':
        return 'En progreso';
      case 'completada':
        return 'Completada';
      default:
        return 'No definido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: tema.surface),
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSecundario(
                          texto: tarea.titulo ?? '',
                          colorTexto: tema.onSurface),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            LabelItemTarea(
                                size: size,
                                text: tarea.categorium?.nombre ?? '',
                                prevTooltip: 'Categoría',
                                icono: Icons.topic_outlined),
                            SizedBox(width: size.width * 0.02),
                            LabelItemTarea(
                              size: size,
                              text: tarea.prioridad?.nombre ?? '',
                              prevTooltip: 'Prioridad',
                              icono: Icons.hourglass_top_rounded,
                            )
                          ],
                        ),
                      ),
                      TextParrafo(texto: tarea.descripcion ?? '')
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextParrafo(
                      texto: getNameStatus(tarea.estado),
                      colorTexto: tema.primary,
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ButtonTarea(
                    texto: 'Editar',
                    funcion: () {
                      final categoriaprovider = Provider.of<CategoriaProvider>(
                          context,
                          listen: false);
                      final prioridadprovider = Provider.of<PrioridadProvider>(
                          context,
                          listen: false);
                      categoriaprovider.idCategoriaSelected =
                          tarea.categorium?.id ?? 0;
                      categoriaprovider.nombreCategoriaSelected =
                          tarea.categorium?.nombre ?? '';
                      prioridadprovider.idPrioridadSelected =
                          tarea.prioridad?.id ?? 0;
                      prioridadprovider.prioridadSelected =
                          tarea.prioridad?.nombre ?? '';
                      CategoriaController(categoriaProvider: categoriaprovider)
                          .traerCategorias(context);
                      PrioridadController(prioridadProvider: prioridadprovider)
                          .traerPrioridades(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ActualizarTareaScreen(
                                    tarea: tarea,
                                  )));
                    },
                    icono: Icons.edit_outlined,
                  ),
                ),
                Expanded(
                  child: ButtonTarea(
                    texto: 'Comentarios',
                    funcion: () {
                      final comentarioprovider =
                          Provider.of<ComentarioProvider>(context,
                              listen: false);
                      comentarioprovider.listComentarios = [];
                      ComentarioController(
                              comentarioProvider: comentarioprovider)
                          .traerComentarios(context, idTarea: tarea.id ?? 0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ComentariosTareaScreen(
                                    tarea: tarea,
                                  )));
                    },
                    icono: Icons.chat_outlined,
                  ),
                ),
                Expanded(
                  child: ButtonTarea(
                    texto: 'Estado',
                    funcion: () {
                      dialogEstados(
                          TareaController(
                              tareaProvider: Provider.of<TareaProvider>(context,
                                  listen: false)),
                          tarea,
                          context);
                    },
                    icono: Icons.change_circle_outlined,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
