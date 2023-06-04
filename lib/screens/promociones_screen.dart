import 'package:flutter/material.dart';
import 'package:gymfo/models/models.dart';
import 'package:gymfo/screens/screens.dart';
import 'package:gymfo/widgets/appbar_widget.dart';

class PromocionesScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Promo promo;
  final Color color;
  const PromocionesScreen({super.key, required this.promo, required this.clienteActual, required this.color});

  @override
  State<PromocionesScreen> createState() => _PromocionesScreenState();
}

class _PromocionesScreenState extends State<PromocionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(
              width: 2,
              color: Colors.black
            )),
            color: widget.color
          ),
          child: Text(widget.promo.nombre, style: TextStyle(fontSize: 32), textAlign: TextAlign.center,)),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.color,
                border: Border(bottom: BorderSide(
                width: 2,
                color: Colors.black
              )),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Text(
                  widget.promo.descripcion,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(widget.promo.ruta),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30,),
          ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PromoForm(promo: widget.promo, clienteActual: widget.clienteActual, color: widget.color,)
                      ),
                    );
                }, 
              child: Text("Inscribirse")),
      ],),
    );
  }
}