import 'package:flutter/material.dart';
import 'package:gymfo/screens/detalles_maquina_screen.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/services.dart';

class MaquinaScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Color color;
  const MaquinaScreen({super.key, required this.clienteActual, required this.color});

  @override
  State<MaquinaScreen> createState() => _MaquinaScreenState();
}

class _MaquinaScreenState extends State<MaquinaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Consumer<MaquinaService>(
        builder: (context, maquinaService, _) {
          if (maquinaService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: maquinaService.maquinas.length,
              itemBuilder: (context, index) {
                final maquina = maquinaService.maquinas[index];
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
                        backgroundImage: NetworkImage(maquina.imagen),
                      ),
                    ),
                    title: Text(maquina.nombre, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetallesMaquinaScreen(maquina: maquina, clienteActual: widget.clienteActual, color: widget.color,),
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