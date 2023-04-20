import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSecundario extends StatelessWidget {
  const TextSecundario({
    Key? key, required this.texto, this.colorTexto = Colors.black54, this.textAlign = TextAlign.center, this.fontWeight,
  }) : super(key: key);

  final String texto;
  final Color? colorTexto;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
    textAlign: textAlign,
        style: GoogleFonts.poppins(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: 15,
          color: colorTexto
        ));
  }
}