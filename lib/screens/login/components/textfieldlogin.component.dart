import 'package:flutter/material.dart';

import '../../../providers/auth.provider.dart';

Padding loginTextField(bool vertical, Size size, AuthProvider authProvider,
    TextEditingController controllertext, String hinttext, IconData icono, Function() funcion, {
      bool secreto = false, 
      String errorText = ''
    }) {
  return Padding(
    padding: EdgeInsets.only(
      top: vertical ? size.width * 0.025 : 15,
      bottom: vertical ? size.height * 0.01 : 10,
      left: size.width * 0.04,
      right: size.width * 0.04,
    ),
    child: TextField(
      obscureText: secreto,
      controller: controllertext,
      decoration: InputDecoration(
        errorText: errorText!=''?errorText:null,
          suffixIcon: IconButton(icon: Icon(icono), onPressed: funcion,),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      authProvider.errorCampos ? Colors.red : Colors.black26)),
          border: const OutlineInputBorder(),
          hintText: hinttext),
    ),
  );
}
