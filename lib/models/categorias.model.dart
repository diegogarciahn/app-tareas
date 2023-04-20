import 'dart:convert';

List<Categoria> categoriasFromJson(String str) => List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriasToJson(List<Categoria> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
    Categoria({
        this.id,
        this.nombre,
        this.descripcion,
    });

    int? id;
    String? nombre;
    String? descripcion;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
