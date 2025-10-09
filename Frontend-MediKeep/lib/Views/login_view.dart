import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register_view.dart';  //  importa el archivo de registro

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String apiUrl = 'https://medikeep.onrender.com'; 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showError = false; //  para mostrar el mensaje rojo

  Future<bool> _login() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'correo': emailController.text,
          'contrasena': passwordController.text,
        }),
      );
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
      print(responseData);
        //  lógica: si responseData tiene 'usuario', es éxito
        if (responseData != null &&
            responseData['message'] == ""
            ) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/image_fondo.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center( //  centra el contenido
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Logo + título
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/medikepp_logo.png',
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Inicio de sesión',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 0.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Correo
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Correo*',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo',
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 25),

                    // Contraseña
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contraseña*',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Botón Iniciar Sesión
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool success = await _login();
                          if (success) {
                            Navigator.pushNamed(context, '/dashboard',
                                arguments: emailController.text);
                          } else {
                            setState(() {
                              _showError = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF339966),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Mensaje de error
                    if (_showError)
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Text(
                          'Correo o contraseña incorrectos. Intenta nuevamente. si no cuentas con una cuenta regístrate',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    const SizedBox(height: 30),

                    // Texto + botón Crear cuenta
                    const Text(
                      '¿No tienes una cuenta?',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF42A5F5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        child: const Text(
                          'Crear una cuenta',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







