// To parse this JSON data, do
//
//     final comentarios = comentariosFromJson(jsonString);

import 'dart:convert';

List<Comentario> comentariosFromJson(String str) => List<Comentario>.from(json.decode(str).map((x) => Comentario.fromJson(x)));

String comentariosToJson(List<Comentario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comentario {
    Comentario({
        this.id,
        this.contenido,
        this.idUsuario,
        this.idTarea,
        this.fecha,
        this.tareaId,
        this.userIdUsuario,
    });

    int? id;
    String? contenido;
    int? idUsuario;
    int? idTarea;
    DateTime? fecha;
    dynamic tareaId;
    dynamic userIdUsuario;

    factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json["id"],
        contenido: json["contenido"],
        idUsuario: json["idUsuario"],
        idTarea: json["idTarea"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        tareaId: json["tareaId"],
        userIdUsuario: json["userIdUsuario"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contenido": contenido,
        "idUsuario": idUsuario,
        "idTarea": idTarea,
        "fecha": fecha?.toIso8601String(),
        "tareaId": tareaId,
        "userIdUsuario": userIdUsuario,
    };
}
