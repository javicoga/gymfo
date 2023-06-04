import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gymfo/screens/home_screen.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import '../models/models.dart';

class ContratarForm extends StatefulWidget {
  final Cliente clienteActual;
  final Entrenador entrenador;
  final Color color;
  const ContratarForm({super.key, required this.entrenador, required this.clienteActual, required this.color});

  @override
  State<ContratarForm> createState() => _ContratarFormState();
}

class _ContratarFormState extends State<ContratarForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  int _selectedMonths = 1;
  int _cost = 30;
  int diaSeleccionado = DateTime.now().day;
  int mesSeleccionado = DateTime.now().month;
  int horaSeleccionada = DateTime.now().hour;
  int minutoSeleccionado = DateTime.now().minute;
  String nombreMesSeleccionado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: FormBuilder(
        key: _fbKey,
        initialValue: {
          'diaInicio': DateTime.now(),
          'meses': _selectedMonths,
        },
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'diaInicio',
                  decoration: InputDecoration(labelText: 'Día de inicio', icon: Image.asset('icons/calendario.png', width: 32, height: 32,),),
                  onChanged: (value){
                    setState(() {
                      diaSeleccionado = value!.day;
                      mesSeleccionado = value.month;
                      horaSeleccionada = value.hour;
                      minutoSeleccionado = value.minute;
                      nombreMesSeleccionado = parseMonthToString(mesSeleccionado);
                    });
                  },
                ),
                FormBuilderRadioGroup(
                  name: 'meses',
                  decoration: InputDecoration(labelText: 'Meses', labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  options: [
                    FormBuilderFieldOption(value: 1),
                    FormBuilderFieldOption(value: 3),
                    FormBuilderFieldOption(value: 6),
                    FormBuilderFieldOption(value: 12),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedMonths = value!;
                      if (value == 1) {
                        _cost = 30;
                      } else if (value == 3) {
                        _cost = 50;
                      } else if (value == 6) {
                        _cost = 70;
                      } else if (value == 12) {
                        _cost = 100;
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('Coste: $_cost€', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                  onPressed: () {
                    _fbKey.currentState!.save();
                    if (_fbKey.currentState!.validate()) {
                      showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.asset('icons/calendario.png', width: 32, height: 32,),
                        title: Text('Contrato realizado'),
                        content: Text('Gracias por por contratar a ${widget.entrenador.nombre}, empezarás el día $diaSeleccionado de $nombreMesSeleccionado a las $horaSeleccionada:$minutoSeleccionado'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomeScreen(clienteActual: widget.clienteActual, color: widget.color,),
                              ),);
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },);
                    }
                  },
                  child: Text('Contratar a ${widget.entrenador.nombre}'),
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


