import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../globals/functions/functions.dart';
import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class ComentariosTareaScreen extends StatefulWidget {
  const ComentariosTareaScreen({Key? key, required this.tarea})
      : super(key: key);

  final Tarea tarea;

  @override
  State<ComentariosTareaScreen> createState() => _ComentariosTareaScreenState();
}

class _ComentariosTareaScreenState extends State<ComentariosTareaScreen> {
  TextEditingController comentarioController = TextEditingController();
  ValidacionesTextField check = ValidacionesTextField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    final comentarioprovider = Provider.of<ComentarioProvider>(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child:
                    AppBar(title: const TextSecundario(texto: 'Comentarios')),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(color: tema.surface),
                  padding: EdgeInsets.only(
                      bottom: 12,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  margin: const EdgeInsets.only(bottom: 8),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSecundario(texto: widget.tarea.titulo ?? ''),
                      TextParrafo(texto: widget.tarea.descripcion ?? '')
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, i) => ComentarioItem(
                            comentario: comentarioprovider.listComentarios[i],
                            size: size,
                            tema: tema,
                            comentarioProvider: comentarioprovider,
                            tarea: widget.tarea,
                          ),
                      childCount: comentarioprovider.listComentarios.length)),
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              )
            ],
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: tema.surface),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: comentarioController,
                  decoration:
                      const InputDecoration(hintText: 'Escribir mensaje...'),
                )),
                IconButton(
                    onPressed: () {
                      if (comentarioController.text.isNotEmpty) {
                        final controller = ComentarioController(
                            comentarioProvider: comentarioprovider);
                        controller
                            .crearComentario(context,
                                contenido: comentarioController.text,
                                idTarea: widget.tarea.id ?? 0)
                            .then((value) {
                          if (value) {
                            comentarioController.clear();
                            FocusScope.of(context).unfocus();
                            controller.traerComentarios(context,
                                idTarea: widget.tarea.id ?? 0);
                          }
                        });
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ),
        if (comentarioprovider.loading) CargandoWidget(size: size, tema: tema)
      ],
    );
  }
}

class ComentarioItem extends StatelessWidget {
  const ComentarioItem({
    Key? key,
    required this.comentario,
    required this.size,
    required this.tema,
    required this.comentarioProvider,
    required this.tarea,
  }) : super(key: key);

  final Comentario comentario;
  final Size size;
  final ColorScheme tema;
  final ComentarioProvider comentarioProvider;
  final Tarea tarea;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            bottom: 10, left: size.width * 0.02, right: size.width * 0.02),
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 7),
        decoration: BoxDecoration(
            color: tema.surface,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextParrafo(
                    texto: comentario.contenido ?? '',
                    textAlign: TextAlign.left,
                  ),
                ),
                PopupMenuButton(
                    itemBuilder: ((context) => [
                          PopupMenuItem<int>(
                            value: 1,
                            onTap: () {
                              final controller = ComentarioController(
                                  comentarioProvider: comentarioProvider);
                              controller
                                  .eliminarComentario(context,
                                      idComentario: comentario.id ?? 0)
                                  .then((value) {
                                if (value) {
                                  controller.traerComentarios(context,
                                      idTarea: tarea.id ?? 0);
                                }
                              });
                            },
                            child: const Text('Eliminar'),
                          ),
                        ]))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextParrafo(
                  texto:
                      '${comentario.fecha?.day}-${comentario.fecha?.month}-${comentario.fecha?.year}',
                  colorTexto: tema.onSurfaceVariant,
                )
              ],
            )
          ],
        ));
  }
}
