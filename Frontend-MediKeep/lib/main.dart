import 'package:flutter/material.dart'; // Trae Flutter y sus widgets.
import 'app.dart'; // Aquí va la  App principal con rutas y vistas

void main() { // main es el punto de entrada de Flutter.
  runApp(const MyApp()); //arranca la app y le pasa el widget raíz (MyApp).

}

class MyApp extends StatelessWidget { //es el widget raíz de la aplicación.
  const MyApp({super.key}); //porque no cambia su estado; solo inicializa la app.

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(), // Pantalla inicial de la app
    );
  }
}
