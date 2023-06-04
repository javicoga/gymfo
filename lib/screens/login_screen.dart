import 'package:flutter/material.dart';
import 'package:gymfo/screens/home_screen.dart';
import 'package:gymfo/screens/registro_screen.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  
  bool _datosIncorrectos = false;
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _datosIncorrectos = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKeyLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', floatingLabelStyle: TextStyle(color: Colors.green[900]) ,focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa un email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa una contraseña';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green[900])
                ),
                key: Key('botonLogin'),
                onPressed: () async {
                  if (_formKeyLogin.currentState!.validate()) {
                  ClienteService clienteService = Provider.of<ClienteService>(context, listen: false,);
                  Cliente cliente = await clienteService.login(_email, _password);
                  if(cliente.email != ''){
                    print('Inicio de sesión exitoso con el usuario: ${clienteService.clienteActual.email}');
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeScreen(clienteActual: clienteService.clienteActual, color: Color.fromRGBO(27, 94, 32, 1),),
                  ),);
                  }else{
                    setState(() {
                      _datosIncorrectos = true;
                    });
                    print('El usuario no existe');
                  }
                  
                }
                },
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => RegistroScreen(),
                  ),);
                },
                child: Text('¿Aún no tienes cuenta? Regístrate aquí', textAlign: TextAlign.center,),
              ),
              Visibility(
                visible: _datosIncorrectos,
                child: Text(
                    'Credenciales inválidas',
                    style: TextStyle(color: Colors.red,),
                    textAlign: TextAlign.center,
                  ),
                  replacement: Container(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
