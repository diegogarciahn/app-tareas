import 'package:flutter/material.dart';

import '../models/models.dart';

class CategoriaProvider with ChangeNotifier {
  bool _loading = false;
  List<Categoria> _listCategorias = [];

  List<Categoria> get listCategorias => _listCategorias;

  set listCategorias(List<Categoria> value) {
    _listCategorias = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
