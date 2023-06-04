import 'package:flutter/material.dart';
import 'package:gymfo/models/deporte.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class PromoService extends ChangeNotifier {
  bool isLoading = true;
  List<Promo> promos = [];

  PromoService() {
    this.getData();
  }

  Future<List<Promo>> getData() async {
    this.isLoading = true;
    notifyListeners();

    var url = Uri.parse('https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/promo.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> promosMap = json.decode(response.body);

      promosMap.forEach((key, value) {
        Promo tempPromo = Promo.fromJson(value);
        print(tempPromo.nombre);
        tempPromo.id = key;
        this.promos.add(tempPromo);
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    this.isLoading = false;
    notifyListeners();

    return this.promos;
  }
}

