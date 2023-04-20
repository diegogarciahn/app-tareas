import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridItemHome extends StatelessWidget {
  const GridItemHome({
    Key? key,
    required this.size,
    required this.icono,
    required this.labelText,
    required this.funcion,
  }) : super(key: key);

  final Size size;
  final IconData icono;
  final String labelText;
  final Function() funcion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: funcion,
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(vertical: 20, horizontal: size.width * 0.03),
        margin: const EdgeInsets.only(bottom: 7),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 14, spreadRadius: -8)
            ]),
        child: Column(
          children: [
            Icon(
              icono,
              color: tema.primary,
              size: 50,
            ),
            Text(
              labelText,
              style: GoogleFonts.sourceSansPro(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
