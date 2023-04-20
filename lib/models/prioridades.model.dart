// To parse this JSON data, do
//
//     final prioridades = prioridadesFromJson(jsonString);

import 'dart:convert';

List<Prioridad> prioridadesFromJson(String str) => List<Prioridad>.from(json.decode(str).map((x) => Prioridad.fromJson(x)));

String prioridadesToJson(List<Prioridad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prioridad {
    Prioridad({
        this.id,
        this.nombre,
    });

    int? id;
    String? nombre;

    factory Prioridad.fromJson(Map<String, dynamic> json) => Prioridad(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
