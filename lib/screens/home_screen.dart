import 'dart:async';
import 'package:gymfo/screens/deportes_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gymfo/screens/screens.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/services.dart';

class HomeScreen extends StatefulWidget {
  Cliente clienteActual;
  final Color color;
  HomeScreen({super.key, required this.clienteActual, required this.color});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Timer? _timer;
  double _progress = 0.0;
  bool _tarjetaValida = true;
  bool _deporteValido = true;
  int diferenciaEnDias = 0;
  int diferenciaEnDiasDeporte = 0;

  @override
  void initState() {
    super.initState();
    _deporteValido = true;
    _timer = Timer.periodic(Duration(milliseconds:  100), (Timer timer) {
      setState(() {
        _progress -= 0.01;
        if (_progress <= 0) {
          _progress = 1.0;
          _currentIndex = (_currentIndex + 1) % 3;
        }
      });
    });

    setState(() {
      if(widget.clienteActual.tarjeta.fechaVencimiento == ''){
          _tarjetaValida = false;
        }else{
          final DateFormat formatoFecha = DateFormat('dd/MM/yyyy');
          DateTime fechaVencimientoDate = formatoFecha.parse(widget.clienteActual.tarjeta.fechaVencimiento);
          diferenciaEnDias = fechaVencimientoDate.difference(DateTime.now()).inDays;
        }
        if(widget.clienteActual.tarjeta.fechaVencimientoDeporte == ''){
          _deporteValido = false;
        }else{
          final DateFormat formatoFecha = DateFormat('dd/MM/yyyy');
          DateTime fechaVencimientoDeporteDate = formatoFecha.parse(widget.clienteActual.tarjeta.fechaVencimientoDeporte);
          diferenciaEnDiasDeporte = fechaVencimientoDeporteDate.difference(DateTime.now()).inDays;
        }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC8E6C9),
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Consumer<PromoService>(
        builder: (context, promoService, _) {
          if (promoService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(children: [
        SizedBox(height: 20,),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
          ),
          child: Text("INSCRIPCIONES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20,),
        Visibility(
          visible: _tarjetaValida,
          replacement: _contenedorTarjetaNoValida(), // si no tiene tarjeta
          child: _contenedorTarjetaValida(), // si tiene tarjeta
        ),
        SizedBox(height: 20,),
        Visibility(
          visible: _deporteValido,
          replacement: _contenedorDeporteNoValido(), // si no tiene tarjeta
          child: _contenedorDeporteValido(), // si tiene tarjeta
        ),
        SizedBox(height: 20,),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
          ),
          child: Text("PROMOCIONES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),

        SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: widget.color,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(promoService.promos[_currentIndex].nombre, style: TextStyle(fontSize: 24,), textAlign: TextAlign.center,),
          )
          ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PromocionesScreen(promo: promoService.promos[_currentIndex], clienteActual: widget.clienteActual, color: widget.color,),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
              width: 720/2,
              height: 283/2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(promoService.promos[_currentIndex].ruta),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text('${promoService.promos[_currentIndex].precio}€', style: TextStyle(fontSize: 24, color: Colors.white),)
                  ),
              ),
            ),
          ),
            SizedBox(height: 1,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              margin: EdgeInsets.only(left: 20, right: 20),
              width: 360.0,
              height: 10.0,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
            ),
            SizedBox(height: 20,)
          ],
        );
        }
      }),
    );
  }

  Container _contenedorTarjetaNoValida() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
        width: 720/2,
        height: 283/2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      child: Stack(children: [
        Positioned(
          top: -3,
          left: -3,
          child: Container(
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.color,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Text('Aún no estás inscrito en Gymfo', textAlign: TextAlign.center,),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Row(
              children: [
                Text('Inscribirse al uso del gimnasio \ndurante 1 mes por 30€', textAlign: TextAlign.justify,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color)),
                  onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                    title: Text('Confirmar inscripción'),
                    content: Text('¿Quieres confirmar tu inscripción?'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red[900])),
                          child: Text('Cancelar',),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green[900])),
                        child: Text('Confirmar',),
                        onPressed: () {
                          String fechaVencimiento = '';
                          final DateFormat formatoFecha = DateFormat('dd/MM/yyyy');
                          fechaVencimiento = formatoFecha.format(DateTime.now().add(Duration(days: 30)));
                          DateTime fechaVencimientoDate = formatoFecha.parse(fechaVencimiento);

                          setState(() {
                            widget.clienteActual.tarjeta.fechaVencimiento = fechaVencimiento;
                            ClienteService clienteService = Provider.of<ClienteService>(context, listen: false,);
                            clienteService.actualizarCliente(widget.clienteActual);
                            _tarjetaValida = true;
                            diferenciaEnDias = fechaVencimientoDate.difference(DateTime.now()).inDays;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );});
                }, child: Text('Inscribirse'),)
              ],
            )
            )
      ],),
    );
  }

  Container _contenedorTarjetaValida() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
        width: 720/2,
        height: 283/2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      child: Stack(children: [
        Positioned(
          left: -3,
          top: -3,
          child: Container(
            width: 320,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.color,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Tu inscripción es válida hasta el ${widget.clienteActual.tarjeta.fechaVencimiento}', textAlign: TextAlign.center,),
            )
            ),
          ),
        Positioned(
          top: 50,
          left: 55,
          child: RichText(
            text: TextSpan(
              text: '$diferenciaEnDias',
              style: TextStyle(fontSize: 48, color: Colors.black),
              children: [
                TextSpan(
                  text: ' días restantes',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        )
      ],),
    );
  }

  Container _contenedorDeporteValido() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
        width: 720/2,
        height: 283/2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      child: Stack(children: [
        Positioned(
          left: -3,
          top: -3,
          child: Container(
            height: 40,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.color,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Text('Tu inscripción en ${widget.clienteActual.tarjeta.deporteInscrito} es válida hasta el ${widget.clienteActual.tarjeta.fechaVencimientoDeporte}', textAlign: TextAlign.center,)
            ),
          ),
        Positioned(
          top: 50,
          left: 55,
          child: RichText(
            text: TextSpan(
              text: '$diferenciaEnDiasDeporte',
              style: TextStyle(fontSize: 48, color: Colors.black),
              children: [
                TextSpan(
                  text: ' días restantes',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        )
      ],),
    );
  }

  Container _contenedorDeporteNoValido() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
        width: 720/2,
        height: 283/2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      child: Stack(children: [
        Positioned(
          top: -3,
          left: -3,
          child: Container(
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: widget.color,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Text('Aún no estás inscrito en ningún deporte', textAlign: TextAlign.center,),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Row(
              children: [
                Text('Anímate a practicar alguno de \nnuestros deportes de contacto', textAlign: TextAlign.justify,),
                SizedBox(width: 5,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color)),
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeportesScreen(clienteActual: widget.clienteActual, color: widget.color,),));
                }, child: Text('Inscribirse'),)
              ],
            )
            )
      ],),
    );
  }
}