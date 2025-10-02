import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/dashboard_view.dart';
import 'views/register_view.dart'; 
import 'views/profile_view.dart';

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
        
        '/login': (context) => LoginView(),
        '/dashboard': (context) => DashboardScreen(userName: "Camila"),
        '/profile': (context) => const ProfileView(),
        '/register': (context) => RegisterView(), 
      },
    );
  }
}


