import 'package:flutter/material.dart';

import '../models/models.dart';

class CategoriaProvider with ChangeNotifier {
  bool _loading = false;
  List<Categoria> _listCategorias = [];
  int _idCategoriaSelected = 0;
  String _nombreCategoriaSelected = "Seleccione una categoría";

  String get nombreCategoriaSelected => _nombreCategoriaSelected;

  set nombreCategoriaSelected(String value) {
    _nombreCategoriaSelected = value;
    notifyListeners();
  }

  int get idCategoriaSelected => _idCategoriaSelected;

  set idCategoriaSelected(int value) {
    _idCategoriaSelected = value;
    notifyListeners();
  }

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
