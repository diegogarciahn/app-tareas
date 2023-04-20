import 'package:flutter/material.dart';

import '../../constants.dart';

globalSnackBar(String texto, {Color? color = Colors.red}) {
  final snackBar = SnackBar(
    content: Text(texto),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}