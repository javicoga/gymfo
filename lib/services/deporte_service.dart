import 'package:flutter/material.dart';
import 'package:gymfo/models/deporte.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class DeporteService extends ChangeNotifier {
  bool isLoading = true;
  List<Deporte> deportes = [];

  DeporteService() {
    this.getData();
  }

  Future<List<Deporte>> getData() async {
    this.isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/deporte.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> deportesMap = json.decode(response.body);

      deportesMap.forEach((key, value) {
        Deporte tempDeporte = Deporte.fromJson(value);
        print(tempDeporte.nombre);
        tempDeporte.id = key;
        this.deportes.add(tempDeporte);
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    this.isLoading = false;
    notifyListeners();

    return this.deportes;
  }
}

