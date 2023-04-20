import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonXXL extends StatelessWidget {
  const ButtonXXL({
    Key? key,
    required this.funcion,
    required this.texto,
    this.sinMargen = false,
    this.colorFondo, this.colorTexto,
  }) : super(key: key);

  final Function() funcion;
  final String texto;
  final bool? sinMargen;
  final Color? colorFondo;
  final Color? colorTexto;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: (sinMargen!) ? 0 : size.width * 0.04, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: colorFondo 
        ),
        onPressed: funcion,
        child: Text(
          texto,
          style: GoogleFonts.inter(fontWeight: FontWeight.w400, color: colorTexto),
        ),
      ),
    );
  }
}