import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/providers.dart';

Future<String> traerToken(BuildContext context) async {
  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'token').catchError((error) {
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    authProvider.autenticado = false;
    // logoutController(context);
    return '';
  });
  if (token == null) {
    // ignore: use_build_context_synchronously
    // logoutController(context);
    const snackBar = SnackBar(
      content: Text('Por favor inicie sesión para acceder al sistema.'),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    authProvider.autenticado = false;
    return '';
  }
  authProvider.autenticado = true;
  return token;
}
