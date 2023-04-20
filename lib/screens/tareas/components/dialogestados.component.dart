import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';
import '../../../globals/widgets/widgets.dart';
import '../../../models/models.dart';

dialogEstados(TareaController tareacontroller, Tarea tarea, context) {
  showDialog(
      context: context,
      builder: (_) {
        final tema = Theme.of(context).colorScheme;
        return AlertDialog(
          title: const TextSecundario(texto: 'Seleccione un estado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tareacontroller
                        .actualizarTarea(context,
                            idTarea: tarea.id ?? 0,
                            titulo: tarea.titulo ?? '',
                            descripcion: tarea.descripcion ?? '',
                            estado: 'pendiente',
                            idCategoria: tarea.categorium?.id ?? 0,
                            idPrioridad: tarea.prioridad?.id ?? 0)
                        .then((value) => tareacontroller.traerTareas(context));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stop_circle_outlined, color: tema.primary),
                      const TextParrafo(
                        texto: 'Pendiente',
                      ),
                    ],
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tareacontroller
                        .actualizarTarea(context,
                            idTarea: tarea.id ?? 0,
                            titulo: tarea.titulo ?? '',
                            descripcion: tarea.descripcion ?? '',
                            estado: 'en_progreso',
                            idCategoria: tarea.categorium?.id ?? 0,
                            idPrioridad: tarea.prioridad?.id ?? 0)
                        .then((value) => tareacontroller.traerTareas(context));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.published_with_changes_sharp,
                          color: tema.primary),
                      const TextParrafo(
                        texto: 'En progreso',
                      ),
                    ],
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    tareacontroller
                        .actualizarTarea(context,
                            idTarea: tarea.id ?? 0,
                            titulo: tarea.titulo ?? '',
                            descripcion: tarea.descripcion ?? '',
                            estado: 'completada',
                            idCategoria: tarea.categorium?.id ?? 0,
                            idPrioridad: tarea.prioridad?.id ?? 0)
                        .then((value) => tareacontroller.traerTareas(context));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: tema.primary),
                      const TextParrafo(
                        texto: 'Completada',
                      ),
                    ],
                  )),
            ],
          ),
        );
      });
}
