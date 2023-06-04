import 'package:flutter/material.dart';
import 'package:gymfo/models/tarjeta.dart';
import 'package:gymfo/screens/screens.dart';
import 'package:gymfo/services/cliente_service.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _email = '';
  String _password = '';
  String _nombre = '';
  String _apellidos = '';
  int _edad = 0;

  Future<void> _registrar() async {
    if (_formKey.currentState!.validate()) {
      ClienteService clienteService = Provider.of<ClienteService>(context, listen: false);
      Cliente cliente = Cliente(apellidos: _apellidos, edad: _edad, email: _email, nombre: _nombre, password: _password, tarjeta: Tarjeta(fechaVencimiento: '', deporteInscrito: '', fechaVencimientoDeporte: ''));
      clienteService.registrar(cliente);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }}

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
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
                  controller: _passwordController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Repetir Contraseña', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, repite la contraseña';
                    } else if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _confirmPasswordController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _nombre = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Apellidos', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tus apellidos';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _apellidos = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Edad', floatingLabelStyle: TextStyle(color: Colors.green[900]), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)))),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa tu edad';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _edad = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green[900])),
                  onPressed: _registrar,
                  child: Text('Registrar'),
                ),
              ],
            ),]
          ),
        ),
      ),
    );
  }
}