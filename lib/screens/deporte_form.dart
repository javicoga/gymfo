import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gymfo/screens/home_screen.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';

import '../services/services.dart';

class DeporteForm extends StatefulWidget {
  final Cliente clienteActual;
  final Deporte deporte;
  final Color color;
  const DeporteForm({super.key, required this.deporte, required this.clienteActual, required this.color});

  @override
  State<DeporteForm> createState() => _DeporteFormState();
}

class _DeporteFormState extends State<DeporteForm> {
  final GlobalKey<FormBuilderState> _fbKey2 = GlobalKey<FormBuilderState>();
  int diaSeleccionado = DateTime.now().day;
  int mesSeleccionado = DateTime.now().month;
  int anyoSeleccionado = DateTime.now().month;
  String nombreMesSeleccionado = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: FormBuilder(
        key: _fbKey2,
        initialValue: {
          'diaInicio': DateTime.now(),
        },
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  name: 'diaInicio',
                  decoration: InputDecoration(labelText: 'Día de inicio', icon: Image.asset('icons/calendario.png', width: 32, height: 32,),),
                  onChanged: (value){
                    setState(() {
                      diaSeleccionado = value!.day;
                      mesSeleccionado = value.month;
                      anyoSeleccionado = value.year;
                      nombreMesSeleccionado = parseMonthToString(mesSeleccionado);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('Coste: ${widget.deporte.precio}€ ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                  onPressed: () {
                    _fbKey2.currentState!.save();
                    if (_fbKey2.currentState!.validate()) {
                      showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.asset('icons/calendario.png', width: 32, height: 32,),
                        title: Text('Inscripción realizada'),
                        content: Text('Gracias por insribirte en ${widget.deporte.nombre}, empezarás el día $diaSeleccionado de $nombreMesSeleccionado'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.clienteActual.tarjeta.deporteInscrito = widget.deporte.nombre;
                                widget.clienteActual.tarjeta.fechaVencimientoDeporte = '$diaSeleccionado/${mesSeleccionado+1}/$anyoSeleccionado';
                                ClienteService clienteService = Provider.of<ClienteService>(context, listen: false,);
                                clienteService.actualizarCliente(widget.clienteActual);
                              });
                          
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(clienteActual: widget.clienteActual, color: widget.color,),));
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },);
                    }
                  },
                  child: Text('Confirmar inscripción'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  String parseMonthToString(int month) {
  switch (month) {
    case 1:
      return 'Enero';
    case 2:
      return 'Febrero';
    case 3:
      return 'Marzo';
    case 4:
      return 'Abril';
    case 5:
      return 'Mayo';
    case 6:
      return 'Junio';
    case 7:
      return 'Julio';
    case 8:
      return 'Agosto';
    case 9:
      return 'Septiembre';
    case 10:
      return 'Octubre';
    case 11:
      return 'Noviembre';
    case 12:
      return 'Diciembre';
    default:
      return '';
  }
}
}