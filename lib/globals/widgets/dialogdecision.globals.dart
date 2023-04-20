import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future dialogDecision(
  String titulo,
  String contenido,
  Function() funcion1,
  Function() funcion2,
  context, {
  String textobtn1 = '',
  String textobtn2 = '',
}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            titulo,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: Text(contenido,
              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w400)),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: funcion1,
                child: Text(
                  (textobtn1 == '') ? 'Aceptar' : textobtn1,
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: funcion2,
                child: Text(
                  (textobtn2 == '') ? 'Cancelar' : textobtn2,
                  style: GoogleFonts.sourceSansPro(),
                )),
          ],
        );
      });
}
