import 'dart:convert';

Tarjeta tarjetaFromJson(String str) => Tarjeta.fromJson(json.decode(str));

String tarjetaToJson(Tarjeta data) => json.encode(data.toJson());

class Tarjeta {
    String deporteInscrito;
    String fechaVencimiento;
    String fechaVencimientoDeporte;

    Tarjeta({
        required this.deporteInscrito,
        required this.fechaVencimiento,
        required this.fechaVencimientoDeporte,
    });

    factory Tarjeta.fromJson(Map<String, dynamic> json) => Tarjeta(
        deporteInscrito: json["deporteInscrito"],
        fechaVencimiento: json["fechaVencimiento"],
        fechaVencimientoDeporte: json["fechaVencimientoDeporte"],
    );

    Map<String, dynamic> toJson() => {
        "deporteInscrito": deporteInscrito,
        "fechaVencimiento": fechaVencimiento,
        "fechaVencimientoDeporte": fechaVencimientoDeporte,
    };
}
