import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_medikeep_1/Utils/config.dart';
import '../Widgets/navbar_menu.dart';
import 'edit_profile_view.dart';
import 'dashboard_view.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  final String id;
  const ProfileView({super.key, required this.id});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic> usuario = {};
  String userName = "";

  @override
  void initState() {
    super.initState();
    _fetchUsuario(widget.id);
    _getuser();
  }

  // Traer datos del usuario desde la API

  Future<void> _fetchUsuario(String userId) async {
    final url = Uri.parse('${Config.serverUrl}usuario/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          usuario = data;
        });
      } else {
        print('Error al cargar usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción al obtener usuario: $e');
    }
  }

  Future<void> _getuser() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.serverUrl}usuario/${widget.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          userName = responseData['correo'];
        });
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Calcular edad a partir de fecha de nacimiento DD/MM/YYYY
  String calcularEdad(String fechaNacimiento) {
    try {
      final partes = fechaNacimiento.split('/'); // "DD/MM/YYYY"
      final dia = int.parse(partes[0]);
      final mes = int.parse(partes[1]);
      final anio = int.parse(partes[2]);
      final nacimiento = DateTime(anio, mes, dia);
      final hoy = DateTime.now();
      int edad = hoy.year - nacimiento.year;
      if (hoy.month < nacimiento.month ||
          (hoy.month == nacimiento.month && hoy.day < nacimiento.day)) {
        edad--;
      }
      return edad.toString();
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    final double avatarRadius = screenWidth * 0.14;
    final double horizontalPadding = screenWidth * 0.06;

    return NavBarMenu(
      id: widget.id,
      userName: userName,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image_fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              8,
              horizontalPadding,
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flecha atrás
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                              userName: userName,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // Avatar
                Center(
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: const Color.fromRGBO(158, 158, 158, 1.0),
                    child: Icon(
                      Icons.person,
                      size: avatarRadius * 0.6,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Campos
                _buildProfileField(
                  label: "Nombre",
                  hint: usuario['nombre'] ?? "",
                ),
                _buildProfileField(
                  label: "Apellido",
                  hint: usuario['apellido'] ?? "",
                ),
                _buildProfileField(
                  label: "Fecha de nacimiento",
                  hint: usuario['fechaNacimiento'] ?? "",
                ),
                _buildProfileField(
                  label: "Teléfono",
                  hint: usuario['telefono'] ?? "",
                ),
                _buildProfileField(
                  label: "Edad",
                  hint: usuario['fechaNacimiento'] != null
                      ? calcularEdad(usuario['fechaNacimiento'])
                      : "",
                ),
                _buildProfileField(
                  label: "Enfermedad",
                  hint: usuario['enfermedad'] ?? "",
                ),

                SizedBox(height: screenHeight * 0.03),

                // Botón editar perfil
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7 > 360 ? 360 : screenWidth * 0.7,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileView(id: widget.id),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(51, 153, 102, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Editar Perfil",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // Cerrar sesión
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7 > 360 ? 360 : screenWidth * 0.7,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Cerrar Sesión",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label *",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color.fromRGBO(255, 255, 255, 0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
