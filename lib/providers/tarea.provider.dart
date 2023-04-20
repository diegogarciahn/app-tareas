import 'package:flutter/material.dart';

import '../models/models.dart';

class TareaProvider with ChangeNotifier {
  bool _loading = false;
  List<Tarea> _listTareas = [];

  List<Tarea> get listTareas => _listTareas;

  set listTareas(List<Tarea> value) {
    _listTareas = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
