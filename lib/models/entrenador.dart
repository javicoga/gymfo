import 'dart:convert';

Map<String, Entrenador> entrenadorFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Entrenador>(k, Entrenador.fromJson(v)));

String entrenadorToJson(Map<String, Entrenador> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Entrenador {
    Entrenador({
        required this.descripcion,
        required this.especialidad,
        required this.imagen,
        required this.nombre,
        required this.youtube,
        required this.instagram,
        this.dni
    });

    String descripcion;
    String especialidad;
    String imagen;
    String nombre;
    String? dni;
    String youtube;
    String instagram;

    factory Entrenador.fromJson(Map<String, dynamic> json) => Entrenador(
        descripcion: json["descripcion"],
        especialidad: json["especialidad"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        youtube: json["youtube"],
        instagram: json["instagram"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "especialidad": especialidad,
        "imagen": imagen,
        "nombre": nombre,
        "youtube": youtube,
        "instagram": instagram,
    };
}
