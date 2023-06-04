import 'dart:convert';

Map<String, Promo> promoFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Promo>(k, Promo.fromJson(v)));

String promoToJson(Map<String, Promo> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Promo {
    String descripcion;
    String nombre;
    int precio;
    String ruta;
    String? id;

    Promo({
        required this.descripcion,
        required this.nombre,
        required this.precio,
        required this.ruta,
        this.id,
    });

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        descripcion: json["descripcion"],
        nombre: json["nombre"],
        precio: json["precio"],
        ruta: json["ruta"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "nombre": nombre,
        "precio": precio,
        "ruta": ruta,
    };
}
