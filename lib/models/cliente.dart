import 'dart:convert';
import 'package:gymfo/models/tarjeta.dart';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    String apellidos;
    int edad;
    String email;
    String nombre;
    String password;
    String? id;
    Tarjeta tarjeta;
    
    Cliente({
        required this.apellidos,
        required this.edad,
        required this.email,
        required this.nombre,
        required this.password,
        this.id,
        required this.tarjeta,
    });

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        apellidos: json["apellidos"],
        edad: json["edad"],
        email: json["email"],
        nombre: json["nombre"],
        password: json["password"],
        tarjeta: Tarjeta.fromJson(json["tarjeta"]),
    );

    Map<String, dynamic> toJson() => {
        "apellidos": apellidos,
        "edad": edad,
        "email": email,
        "nombre": nombre,
        "password": password,
        "tarjeta": tarjeta.toJson(),
    };
}
