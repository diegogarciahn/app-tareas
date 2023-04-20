import 'package:flutter/material.dart';

import '../models/models.dart';

class ComentarioProvider with ChangeNotifier {
  bool _loading = false;
  List<Comentario> _listComentarios = [];

  List<Comentario> get listComentarios => _listComentarios;

  set listComentarios(List<Comentario> value) {
    _listComentarios = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
