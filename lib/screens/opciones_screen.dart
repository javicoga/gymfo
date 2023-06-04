import 'package:flutter/material.dart';
import 'package:gymfo/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/models.dart';
import '../services/cliente_service.dart';

class OpcionesScreen extends StatefulWidget {
  final Cliente clienteActual;
  const OpcionesScreen({super.key, required this.clienteActual});

  @override
  State<OpcionesScreen> createState() => _OpcionesScreenState();
}

class _OpcionesScreenState extends State<OpcionesScreen> {
  Color selectedColor = Color.fromRGBO(27, 94, 32, 1); // Variable para almacenar el color seleccionado

  void changeColor(Color color) {
    setState(() {
      selectedColor = color; // Actualizar el color seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    final clienteService = Provider.of<ClienteService>(context);

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Opciones'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tus datos',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.0),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: TextEditingController(text: clienteService.clienteActual.email),
              onChanged: (value) {
                clienteService.clienteActual.email = value;
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              controller: TextEditingController(text: clienteService.clienteActual.password),
              onChanged: (value) {
                clienteService.clienteActual.password = value;
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              controller: TextEditingController(text: clienteService.clienteActual.nombre),
              onChanged: (value) {
                clienteService.clienteActual.nombre = value;
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Apellidos'),
              controller: TextEditingController(text: clienteService.clienteActual.apellidos),
              onChanged: (value) {
                clienteService.clienteActual.apellidos = value;
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Edad'),
              controller: TextEditingController(text: clienteService.clienteActual.edad.toString()),
              onChanged: (value) {
                clienteService.clienteActual.edad = int.parse(value);
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24.0),
             Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Tema:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Selecciona un color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: selectedColor,
                          onColorChanged: changeColor,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Aceptar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedColor,
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green[900])
              ),
              onPressed: () {
                clienteService.actualizarCliente(widget.clienteActual);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(clienteActual: widget.clienteActual, color: selectedColor),));
              },
              child: Text('Guardar cambios'),
            ),
        ],
        ),
      ),
    );
  }
}