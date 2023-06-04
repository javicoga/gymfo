import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class MaquinaService extends ChangeNotifier {
  bool isLoading = true;
  List<Maquina> maquinas = [];

  MaquinaService() {
    this.getData();
  }

  Future<List<Maquina>> getData() async {
    this.isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/maquina.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> maquinasMap = json.decode(response.body);

      maquinasMap.forEach((key, value) {
        Maquina tempMaquina = Maquina.fromJson(value);
        print(tempMaquina.nombre);
        tempMaquina.id = key;
        this.maquinas.add(tempMaquina);
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    this.isLoading = false;
    notifyListeners();

    return this.maquinas;
  }
}

