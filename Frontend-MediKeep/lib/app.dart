import 'package:flutter/material.dart';
import 'views/splash_view.dart';
import 'views/login_view.dart';
import 'views/dashboard_view.dart';
import 'views/perfil_view.dart';
import 'views/medicamentos_view.dart';
import 'views/historial_view.dart';
import 'views/register_view.dart'; // 👈 asegúrate que la carpeta es views/

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediKeep',
      debugShowCheckedModeBanner: false,

      // Tema global de la app
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),

      // Pantalla inicial
      initialRoute: '/dashboard',


      // Rutas de la app
      routes: {
        '/splash': (context) => SplashView(),
        '/login': (context) => LoginView(),
        '/dashboard': (context) => DashboardScreen(userName: "Camila"),
        '/perfil': (context) => PerfilView(),
        '/medicamento': (context) => MedicamentoView(),
        '/historial': (context) => HistorialView(),
        '/register': (context) => RegisterView(), 
      },
    );
  }
}


