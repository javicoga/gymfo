import 'package:flutter/material.dart';
import 'package:gymfo/screens/detalles_entrenador_screen.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/services.dart';

class EntrenadorScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Color color;
  const EntrenadorScreen({super.key, required this.clienteActual, required this.color});

  @override
  State<EntrenadorScreen> createState() => _EntrenadorScreenState();
}

class _EntrenadorScreenState extends State<EntrenadorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Consumer<EntrenadorService>(
        builder: (context, entrenadorService, _) {
          if (entrenadorService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: entrenadorService.entrenadores.length,
              itemBuilder: (context, index) {
                final entrenador = entrenadorService.entrenadores[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: widget.color, width: 10),)
                    ),
                  child: ListTile(
                    minVerticalPadding: 30,
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(entrenador.imagen),
                      ),
                    ),
                    title: Text(entrenador.nombre, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetallesEntrenadorScreen(entrenador: entrenador, clienteActual: widget.clienteActual, color: widget.color,),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}