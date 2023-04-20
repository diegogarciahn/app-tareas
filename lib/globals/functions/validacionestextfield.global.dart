import 'package:flutter/material.dart';

class ValidacionesTextField {
  bool error = false;
  String errorText = '';
  final _decimal = RegExp(r'^(0|[1-9]\d*)(\.\d+)?$');

  bool isEmpty(TextEditingController textEditingController) {
    if (textEditingController.text.isEmpty) {
      error = true;
      errorText = 'Este campo es obligatorio';
      return false;
    }
    error = false;
    return true;
  }

  bool numMax(
      TextEditingController textEditingController, int numMax) {
    if (error != true) {
      if (num.parse(textEditingController.text) > numMax) {
        error = true;
        errorText = 'El número de semana no puede ser mayor a $numMax';
        return false;
      }
    }
    return true;
  }

  bool isDecimal(TextEditingController textEditingController) {
    if (!error) {
      if (!_decimal.hasMatch(textEditingController.text)) {
        error = true;
        errorText = 'Este campo debe ser un número decimal o entero.';
        return false;
      }
      return true;
    }
    return false;
  }
}
