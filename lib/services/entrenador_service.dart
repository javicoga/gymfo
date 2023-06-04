import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class EntrenadorService extends ChangeNotifier {
  bool isLoading = true;
  List<Entrenador> entrenadores = [];

  EntrenadorService() {
    this.getData();
  }

  Future<List<Entrenador>> getData() async {
    this.isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/entrenador.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> entrenadoresMap = json.decode(response.body);

      entrenadoresMap.forEach((key, value) {
        Entrenador tempEntrenador = Entrenador.fromJson(value);
        print(tempEntrenador.nombre);
        tempEntrenador.dni = key;
        this.entrenadores.add(tempEntrenador);
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    this.isLoading = false;
    notifyListeners();

    return this.entrenadores;
  }
}

