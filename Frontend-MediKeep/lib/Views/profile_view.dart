import 'package:flutter/material.dart';
import '../Widgets/navbar_menu.dart';
import 'edit_profile_view.dart';
import 'dashboard_view.dart'; // ✅ Importamos DashboardScreen
import 'login_view.dart'; // ✅ Importamos LoginView

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    final double avatarRadius = screenWidth * 0.14;
    final double horizontalPadding = screenWidth * 0.06;

    return NavBarMenu(
      userName: "Maria",
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image_fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Flecha atrás -> Dashboard
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(
                              userName: "Maria", // ✅ pasamos userName
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
                _buildProfileField(label: "Nombre", hint: "Nombre"),
                _buildProfileField(label: "Apellido", hint: "Apellido"),
                _buildProfileField(label: "Fecha de nacimiento", hint: "DD / MM / YYYY"),
                _buildProfileField(label: "Teléfono", hint: "Teléfono"),
                _buildProfileField(label: "Edad", hint: "Edad"),
                _buildProfileField(label: "Enfermedad", hint: "Enfermedad"),

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
                          MaterialPageRoute(builder: (context) => const EditProfileView()),
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

                // 🔹 Botón cerrar sesión -> LoginView
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7 > 360 ? 360 : screenWidth * 0.7,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
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

  Widget _buildProfileField({
    required String label,
    required String hint,
  }) {
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}



