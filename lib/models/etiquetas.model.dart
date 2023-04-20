// To parse this JSON data, do
//
//     final etiquetas = etiquetasFromJson(jsonString);

import 'dart:convert';

List<Etiqueta> etiquetasFromJson(String str) => List<Etiqueta>.from(json.decode(str).map((x) => Etiqueta.fromJson(x)));

String etiquetasToJson(List<Etiqueta> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Etiqueta {
    Etiqueta({
        this.id,
        this.nombre,
    });

    int? id;
    String? nombre;

    factory Etiqueta.fromJson(Map<String, dynamic> json) => Etiqueta(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
