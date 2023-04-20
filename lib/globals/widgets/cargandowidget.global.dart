import 'package:flutter/material.dart';

class CargandoWidget extends StatelessWidget {
  const CargandoWidget({
    Key? key,
    required this.size,
    required this.tema,
  }) : super(key: key);

  final Size size;
  final ColorScheme tema;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black26,
      child: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            color: tema.primary,
          ),
        ),
      ),
    );
  }
}