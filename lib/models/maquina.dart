import 'dart:convert';

Map<String, Maquina> maquinaFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Maquina>(k, Maquina.fromJson(v)));

String maquinaToJson(Map<String, Maquina> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Maquina {
    Maquina({
        required this.descripcion,
        required this.imagen,
        required this.nombre,
        this.video,
        this.id,
    });

    String descripcion;
    String imagen;
    String nombre;
    String? video;
    String? id;

    factory Maquina.fromJson(Map<String, dynamic> json) => Maquina(
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "imagen": imagen,
        "nombre": nombre,
        "video": video,
    };
}
