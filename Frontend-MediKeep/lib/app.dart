import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/dashboard_view.dart';
import 'views/register_view.dart';
import 'views/profile_view.dart';
import 'views/history_view.dart';

class App extends StatelessWidget {
  const App({super.key}); // const -> indica que el constructor es constante (mejor rendimiento cuando es posible)
  // App({super.key}) -> constructor por defecto que recibe la clave del widget

  @override
  Widget build(BuildContext context) {// build(BuildContext context) -> método que construye la UI, recibe BuildContext con info del árbol
    return MaterialApp( // MaterialApp -> widget raíz que configura tema, rutas, etc. (Material Design)
      title: 'MediKeep',
      debugShowCheckedModeBanner: false,

      // Tema global de la app
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),

      // Pantalla inicial
      initialRoute: '/login',

      // Rutas de la app
      routes: {
        '/login': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return ProfileView(id: args ?? '');
        } ,
        '/history': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return HistoryView(id: args ?? '');
        },

        '/dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          // ModalRoute.of(context) -> obtiene la ruta actual del contexto (puede ser null si no hay ruta)
          // ?. -> operador de acceso condicional, evita crash si ModalRoute.of(context) es null
          // settings.arguments -> campo donde Flutter guarda los argumentos pasados por Navigator
          // as String? -> conversión de tipo (cast) a String nullable (puede quedar null)
          // Devuelve el widget DashboardScreen pasándole el argumento userName
          // args ?? 'Invitado' -> si args es null, usa 'Invitado' como valor por defecto
          return DashboardScreen(userName: args ?? 'Invitado');
          
        },
      },
    );
  }
}



