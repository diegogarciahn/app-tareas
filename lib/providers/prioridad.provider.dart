import 'package:flutter/material.dart';

import '../models/models.dart';

class PrioridadProvider with ChangeNotifier {
  bool _loading = false;
  List<Prioridad> _listPrioridades = [];

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
