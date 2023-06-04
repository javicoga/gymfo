import 'package:flutter/material.dart';
import 'package:gymfo/screens/screens.dart';
import 'package:gymfo/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MaquinaService()),
        ChangeNotifierProvider(create: (_) => EntrenadorService()),
        ChangeNotifierProvider(create: (_) => DeporteService()),
        ChangeNotifierProvider(create: (_) => PromoService()),
        ChangeNotifierProvider(create: (_) => ClienteService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymfo',
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginScreen(),
        'registro': (context) => RegistroScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}
