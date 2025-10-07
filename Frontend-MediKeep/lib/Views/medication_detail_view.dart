import 'package:flutter/material.dart';
import '../Widgets/navbar_menu.dart';
import 'history_view.dart';


// 🔹 Recibe un medicamento en el constructor
class MedicationDetailView extends StatefulWidget {
  final Map<String, dynamic> medicamento;
  final String id ;

  const MedicationDetailView({super.key, required this.medicamento, required this.id});

  @override
  State<MedicationDetailView> createState() => _MedicationDetailViewState();
}

class _MedicationDetailViewState extends State<MedicationDetailView> {
  @override
  Widget build(BuildContext context) {
    // Usamos NavBarMenu como root (no añadimos otro Scaffold).
    // Le pasamos el contenido de la pantalla como `child`.
    return NavBarMenu(
      id: widget.id,
      userName: "Maria",
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image_fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox.expand(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Botón volver (debajo del navbar)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryView(id:widget.id,),
                        ),
                      );
                    },
                  ),

                  // Título del medicamento
                  Center(
                    child: Text(
                      widget.medicamento["nombre"] ?? "Medicamento",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campos con los datos recibidos
                  _buildCampo("Descripción", widget.medicamento["descripcion"]),
                  _buildCampo("Dosis", widget.medicamento["dosis"]),
                  _buildCampo("Frecuencia", widget.medicamento["frecuencia"]),
                  _buildCampo("Hora", widget.medicamento["hora"]),
                  _buildCampo("Duración", widget.medicamento["duracion"]),
                  _buildCampo(
                    "Uso prolongado",
                    widget.medicamento["usoProlongado"] == true ? "Sí" : "No",
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí va la lógica de reactivar medicamento (por ahora solo vista)
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Reactivar medicamento",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Método auxiliar para mostrar los datos en campo readOnly
  Widget _buildCampo(String titulo, String? valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$titulo *",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          TextField(
            readOnly: true, // 🔹 Solo lectura
            controller: TextEditingController(text: valor ?? ""),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}











