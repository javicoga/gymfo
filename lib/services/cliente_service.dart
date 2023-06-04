import 'package:flutter/material.dart';
import 'package:gymfo/models/tarjeta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cliente.dart';

class ClienteService extends ChangeNotifier {
  late var data;
  bool isLoading = true;
  List<Cliente> clientes = [];
  Cliente clienteActual = Cliente(apellidos: '', edad: 0, email: '', nombre: '', password: '', tarjeta: Tarjeta(fechaVencimiento: '', deporteInscrito: '', fechaVencimientoDeporte: ''));
  
  
  Future<Cliente> getCliente() async {
    return clienteActual;
  }

  Future<Cliente> login(String email, String password) async {
    this.isLoading = true;

    var url = Uri.parse('https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/cliente.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> clientesMap = json.decode(response.body);

      clientesMap.forEach((key, value) {
        Cliente tempCliente = Cliente.fromJson(value);
        print(' email ${tempCliente.email} email2: $email');
        print(' pass ${tempCliente.password} pass2: $password');
        if (tempCliente.email == email && tempCliente.password == password) {
        clienteActual = tempCliente;
        clienteActual.id = key;
        print('Cliente encontrado: su email es ${clienteActual.email} ${clienteActual.edad}');
      }
    });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    this.isLoading = false;
    notifyListeners();

    return clienteActual;
  }

  Future<void> registrar(Cliente nuevoCliente) async {
      final url = 'https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/cliente.json';
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(nuevoCliente),
      ).then((response) {
        if (response.statusCode == 200) {
          print('Cliente creado con éxito');
        } else {
          print('Error al crear el cliente. Código de estado: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error en la solicitud: $error');
      });
      notifyListeners();
    }

void actualizarCliente(Cliente cliente) async {
  String url = 'https://gymfo-3a349-default-rtdb.europe-west1.firebasedatabase.app/cliente';
  String jsonData = jsonEncode(cliente);

  http.put(
  Uri.parse('$url/${cliente.id}.json'),
  headers: {'Content-Type': 'application/json'},
  body: jsonData,
).then((response) {
  if (response.statusCode == 200) {
    print('Cliente actualizado exitosamente');
  } else {
    print('Error al actualizar el cliente. Código de respuesta: ${response.statusCode}');
  }
}).catchError((error) {
  print('Error en la solicitud HTTP: $error');
});
}
}