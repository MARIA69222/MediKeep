// aviso de cambios guardados con éxito
import 'package:flutter/material.dart';
import '../views/profile_view.dart'; // 🔹 Importamos ProfileView

class NotificationHelper {
  // Método estático para mostrar el modal de confirmación
  static void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // No se cierra tocando afuera
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono dentro de un círculo verde claro
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 254, 255, 254),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF2ECC71),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),

                // Texto título
                const Text(
                  "¡Cambios guardados!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Texto descripción
                const Text(
                  "Tu perfil ha sido actualizado con éxito",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Botón aceptar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // 🔹 Cerramos el modal y navegamos al ProfileView
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

