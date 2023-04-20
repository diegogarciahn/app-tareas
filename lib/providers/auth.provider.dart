import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
    bool _loading = false;
  bool _errorCampos = false;
  bool _ocultarContrasena = true;
  bool _autenticado = false;
  String _textError = '';

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get autenticado => _autenticado;

  set autenticado(bool value) {
    _autenticado = value;
    notifyListeners();
  }

  bool get ocultarContrasena => _ocultarContrasena;

  set ocultarContrasena(bool value) {
    _ocultarContrasena = value;
    notifyListeners();
  }

  bool get errorCampos => _errorCampos;

  set errorCampos(bool value) {
    _errorCampos = value;
    notifyListeners();
  }

  String get textError => _textError;

  set textError(String value) {
    _textError = value;
    notifyListeners();
  }

  resetProvider() {
    _loading = false;
    _errorCampos = false;
    _ocultarContrasena = true;
    _autenticado = false;
    _textError = '';
  }
}