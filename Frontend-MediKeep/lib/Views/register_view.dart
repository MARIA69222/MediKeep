import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                    onChanged: (value) {},
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
                  ),
                  const SizedBox(height: 25),

                  // Aceptar términos
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Text(
                        'Acepto los Términos y condiciones',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Botón "Crear cuenta"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica crear cuenta
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
                        child: Icon(Icons.circle, size: 8, color: Colors.black54),
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
                        // Lógica iniciar sesión
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

      // 👇 Footer fijo abajo
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, top: 8),
        color: Colors.transparent,
        child: const Text(
          'Copyright © 2025',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
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

