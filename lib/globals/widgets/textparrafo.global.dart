import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextParrafo extends StatelessWidget {
  const TextParrafo({
    Key? key,
    required this.texto,
    this.colorTexto = Colors.black,
    this.textAlign,
    this.fontWeight, this.backgroundColor,
  }) : super(key: key);

  final String texto;
  final Color colorTexto;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      style: GoogleFonts.sourceSansPro(
          fontSize: 13,
          color: colorTexto,
          fontWeight: fontWeight ?? FontWeight.normal,
          backgroundColor: backgroundColor),
    );
  }
}
