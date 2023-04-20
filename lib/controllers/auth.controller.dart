import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../globals/functions/functions.dart';
import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/auth.provider.dart';
import '../services/services.dart';

class AuthController {
  static Future<bool> logincontroller(TextEditingController usuario,
      TextEditingController password, context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (usuario.text.isEmpty || password.text.isEmpty) {
      authProvider.errorCampos = true;
      authProvider.textError = 'Por favor complete todos los campos';
    } else {
      authProvider.loading = true;
      final respuesta = await AuthService.loginService(
          usuario.text.trim(), password.text.trim());
      if (respuesta is TokenAndUser) {
        // ignore: prefer_const_constructors
        final storage = FlutterSecureStorage();
        storage.write(key: 'token', value: respuesta.token);
        storage.write(key: 'usuario', value: usuario.text);
        authProvider.loading = false;
        authProvider.errorCampos = false;
        authProvider.textError = '';
        return true;
      } else {
        authProvider.loading = false;
        CuerpoDeController.cuerpoNormal(context,
            mensajeError: 'iniciar sesión',
            funcion400: () => alertError(context,
                mensaje: 'Usuario o contraseña incorrectos'),
            codRespuesta: respuesta);
      }
    }
    authProvider.loading = false;
    return false;
  }
}
