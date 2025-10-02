//aviso de medicamento reactivado con éxito

import 'package:flutter/material.dart';
import '../views/history_view.dart';

class ReactivateSuccessDialog {
  // Método estático para mostrar el modal
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // No cerrar tocando afuera
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícono dentro de un círculo
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0FFF0), // verde muy clarito
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF2ECC71), // verde fuerte
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),

                // Título
                const Text(
                  "¡Listo!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Mensaje
                const Text(
                  "El medicamento ha sido reactivado correctamente",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // cerrar modal
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
