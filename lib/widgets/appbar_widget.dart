import 'package:flutter/material.dart';
import 'package:gymfo/screens/deportes_screen.dart';

import '../models/models.dart';
import '../screens/screens.dart';

AppBar appBar(BuildContext context, Cliente clienteActual, Color color) {
    return AppBar(
      backgroundColor: color,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset('icons/hogar.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomeScreen(clienteActual: clienteActual, color: color,),
              ),),
              ),
              IconButton(
                icon: Image.asset('icons/gimnasio.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MaquinaScreen(clienteActual: clienteActual, color: color),
              ),),
              ),
              IconButton(
                icon: Image.asset('icons/entrenador-personal.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => EntrenadorScreen(clienteActual: clienteActual, color: color),
              ),),
              ),
              IconButton(
                icon: Image.asset('icons/guante-de-boxeo.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => DeportesScreen(clienteActual: clienteActual, color: color),
              ),),
              ),
              IconButton(
                icon: Image.asset('icons/perfil.png',),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => OpcionesScreen(clienteActual: clienteActual,),
              ),),
              ),
              IconButton(
                icon: Image.asset('icons/login.png',),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),),
              ),
            ],
          ),
        ),
      ],
    );
  }