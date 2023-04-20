import 'package:flutter/material.dart';

import '../../../globals/widgets/widgets.dart';

class LabelItemTarea extends StatelessWidget {
  const LabelItemTarea({
    Key? key,
    required this.size,
    required this.text,
    required this.icono,
    required this.prevTooltip,
  }) : super(key: key);

  final Size size;
  final String text;
  final String prevTooltip;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '$prevTooltip: $text',
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono),
            TextParrafo(texto: text),
          ],
        ),
      ),
    );
  }
}