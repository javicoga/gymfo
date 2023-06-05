import 'package:flutter/material.dart';
import 'package:gymfo/screens/detalles_deporte_screen.dart';
import 'package:gymfo/services/services.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class DeportesScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Color color;
  const DeportesScreen({super.key, required this.clienteActual, required this.color});

  @override
  State<DeportesScreen> createState() => _DeporrtesScreenState();
}

class _DeporrtesScreenState extends State<DeportesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Consumer<DeporteService>(
        builder: (context, deporteService, _) {
          if (deporteService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: deporteService.deportes.length,
              itemBuilder: (context, index) {
                final deporte = deporteService.deportes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesDeporteScreen(deporte: deporte, clienteActual: widget.clienteActual, color: widget.color,),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                    width: 720/2,
                    height: 283/2,
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(deporte.imagen),
                    fit: BoxFit.cover,
                    ),
                  ),
                child: Stack(children: [
                  Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text('${deporte.precio}€', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    )
                  ),
                  Positioned(
                  left: 5,
                  bottom: 5,
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text('${deporte.nombre}', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                  )
                ),
              ],)
            ),
          );
          },
        );
        }
        }   
      ),
    );
  }
}