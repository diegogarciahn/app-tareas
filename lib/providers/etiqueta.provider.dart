import 'package:flutter/material.dart';

import '../models/models.dart';

class EtiquetaProvider with ChangeNotifier {
  bool _loading = false;
  List<Etiqueta> _listEtiquetas = [];

  List<Etiqueta> get listEtiquetas => _listEtiquetas;
  
  set listEtiquetas(List<Etiqueta> value) {
    _listEtiquetas = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
