import 'package:flutter/material.dart';
import 'package:gymfo/screens/deporte_form.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import '../models/models.dart';

class DetallesDeporteScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Deporte deporte;
  final Color color;
  const DetallesDeporteScreen({super.key, required this.deporte, required this.clienteActual, required this.color,});

  @override
  State<DetallesDeporteScreen> createState() => _DetallesDeporteScreenState();
}

class _DetallesDeporteScreenState extends State<DetallesDeporteScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                width: 2,
                color: Colors.black
              )),
              color: widget.color
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.deporte.nombre, style: TextStyle(fontSize: 32), textAlign: TextAlign.center,),
                Image.network(widget.deporte.imagen, height: 35,)
              ],
            )
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only( left: 20, right: 20),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(widget.deporte.imagen),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  radius: Radius.circular(50),
                  thickness: 5,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Text(
                      widget.deporte.descripcion,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
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
                    image: NetworkImage(widget.deporte.imagen2),
                    fit: BoxFit.cover,
                    ),
                  ),),
          SizedBox(height: 30,),
          ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeporteForm(deporte: widget.deporte, clienteActual: widget.clienteActual, color: widget.color,)
                      ),
                    );
                }, 
              child: Text("Inscribirse")),
        ],
      ),
    );
  }
}