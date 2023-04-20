import 'package:flutter/material.dart';

import '../models/models.dart';

class PrioridadProvider with ChangeNotifier {
  bool _loading = false;
  List<Prioridad> _listPrioridades = [];
  int _idPrioridadSelected = 0;
  String _prioridadSelected = "Seleccione la prioridad de la tarea";

  String get prioridadSelected => _prioridadSelected;
  set prioridadSelected(String value) {
    _prioridadSelected = value;
    notifyListeners();
  }

  int get idPrioridadSelected => _idPrioridadSelected;

  set idPrioridadSelected(int value) {
    _idPrioridadSelected = value;
    notifyListeners();
  }

  List<Prioridad> get listPrioridades => _listPrioridades;

  set listPrioridades(List<Prioridad> value) {
    _listPrioridades = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
