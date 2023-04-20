import 'package:flutter/material.dart';

import '../../../globals/widgets/widgets.dart';

class ButtonTarea extends StatelessWidget {
  const ButtonTarea({
    Key? key,
    required this.funcion,
    required this.icono,
    required this.texto,
  }) : super(key: key);

  final Function() funcion;
  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: funcion,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, size: 22),
              TextParrafo(
                texto: texto,
              ),
            ],
          ),
        ));
  }
}
