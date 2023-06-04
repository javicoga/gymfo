import 'dart:convert';

Map<String, Deporte> deporteFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Deporte>(k, Deporte.fromJson(v)));

String deporteToJson(Map<String, Deporte> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Deporte {
    String descripcion;
    String imagen;
    String imagen2;
    String nombre;
    int precio;
    String? id;

    Deporte({
        required this.descripcion,
        required this.imagen,
        required this.imagen2,
        required this.nombre,
        required this.precio,
        this.id,
    });

    factory Deporte.fromJson(Map<String, dynamic> json) => Deporte(
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        imagen2: json["imagen2"],
        nombre: json["nombre"],
        precio: json["precio"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "imagen": imagen,
        "imagen2": imagen2,
        "nombre": nombre,
        "precio": precio,
    };
}
