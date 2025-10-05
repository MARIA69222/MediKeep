import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final String apiUrl = 'http://localhost:3001/api/usuario'; 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String? _selectedIdType;

  String result = '';

  Future<void> _register(BuildContext context) async {
    // Validación: verificar que ningún campo esté vacío
    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        dobController.text.isEmpty ||
        _selectedIdType == null ||
        documentController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Completa todos los campos",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nameController.text,
          'correo': emailController.text,
          'contrasena': passwordController.text,
          'numeroDocumento': documentController.text,
          'telefono': phoneController.text,
          'fechaNacimiento': dobController.text,
          'apellido': lastNameController.text,
          'tipoDocumento': _selectedIdType,
          'enfermedad': "",
          'fotoPerfil': "",
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Usuario creado: $responseData");

        // Ir directo al dashboard
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/image_fondo.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botón de retroceso
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Logo + título
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/medikepp_logo.png',
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Registro de cuenta',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Nombre
                  const Text('Nombre*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('Nombre'),
                    controller: nameController,
                  ),
                  const SizedBox(height: 25),

                  // Apellido
                  const Text('Apellido*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('Apellido'),
                    controller: lastNameController,
                  ),
                  const SizedBox(height: 25),

                  // Fecha de nacimiento
                  const Text('Fecha de nacimiento*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('DD / MM / YYYY'),
                    controller: dobController,
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 25),

                  // Documento de identidad
                  const Text('Documento de identidad*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration('Seleccione'),
                    items: const [
                      DropdownMenuItem(
                          value: 'cc', child: Text('Cédula de ciudadanía')),
                      DropdownMenuItem(
                          value: 'ce', child: Text('Cédula de extranjería')),
                      DropdownMenuItem(value: 'pp', child: Text('Pasaporte')),
                    ],
                    onChanged: (value) {
                      _selectedIdType = value;
                    },
                  ),
                  const SizedBox(height: 25),

                  // Número de documento
                  const Text('Número de documento*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('Número de documento'),
                    controller: documentController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25),

                  // Correo electrónico
                  const Text('Correo electrónico*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('Correo electrónico'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 25),

                  // Teléfono
                  const Text('Teléfono*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration('Teléfono'),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 25),

                  // Contraseña
                  const Text('Contraseña*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: _inputDecoration('Contraseña'),
                    controller: passwordController,
                  ),
                  const SizedBox(height: 25),

                  // Botón "Crear cuenta"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _register(context);
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
                        'Crear cuenta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Separador con círculo en el centro
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.circle,
                            size: 8, color: Colors.black54),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // "¿Ya tienes una cuenta?"
                  const Center(
                    child: Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón "Iniciar sesión"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
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
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 70), // espacio al final
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reutilizamos código para inputs
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}



