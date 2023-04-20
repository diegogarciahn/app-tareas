import 'dart:convert';

import 'package:app_tareas/models/models.dart';

List<Tarea> tareasFromJson(String str) => List<Tarea>.from(json.decode(str).map((x) => Tarea.fromJson(x)));

String tareasToJson(List<Tarea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tarea {
    Tarea({
        this.id,
        this.titulo,
        this.descripcion,
        this.estado,
        this.idCategoria,
        this.idPrioridad,
        this.idUsuario,
        this.categorium,
        this.prioridad,
    });

    int? id;
    String? titulo;
    String? descripcion;
    String? estado;
    int? idCategoria;
    int? idPrioridad;
    int? idUsuario;
    Categoria? categorium;
    Prioridad? prioridad;

    factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        idCategoria: json["idCategoria"],
        idPrioridad: json["idPrioridad"],
        idUsuario: json["idUsuario"],
        categorium: json["categorium"] == null ? null : Categoria.fromJson(json["categorium"]),
        prioridad: json["prioridad"] == null ? null : Prioridad.fromJson(json["prioridad"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "estado": estado,
        "idCategoria": idCategoria,
        "idPrioridad": idPrioridad,
        "idUsuario": idUsuario,
        "categorium": categorium?.toJson(),
        "prioridad": prioridad?.toJson(),
    };
}