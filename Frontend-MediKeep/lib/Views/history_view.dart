// Vista: Historial de Medicamentos
import 'package:flutter/material.dart';

// Importamos las pantallas relacionadas.
import 'dashboard_view.dart'; // Pantalla principal (DashboardScreen)
import 'add_view.dart'; // Pantalla para agregar medicamento (AddView)
import 'medication_detail_view.dart'; // Pantalla de detalle de medicamento

// Importamos el nuevo Navbar (asegúrate de que la ruta y nombre de archivo coincidan)
import '../Widgets/navbar_menu.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  // Lista local de medicamentos (vacía por defecto).
  List<Map<String, dynamic>> medicamentos = [];

  // Controla si se muestra la tarjeta emergente inicial (true = se muestra)
  bool mostrarPopupInicial = true;

  // 🔹 Función que abre AddView y espera un resultado
  Future<void> _abrirAddView() async {
    final nuevoMedicamento = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddView()),
    );

    // Si AddView devuelve un medicamento válido, lo agregamos a la lista
    if (nuevoMedicamento != null && nuevoMedicamento is Map<String, dynamic>) {
      setState(() {
        medicamentos.add(nuevoMedicamento);
        mostrarPopupInicial = false; // Ocultamos el popup si se agregó uno
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos NavBarMenu como contenedor principal. NO tocamos la lógica interna.
    return NavBarMenu(
      userName: "Usuario", // muestra nombre y avatar en el header
      // child contiene tod el contenido de la vista (debajo del header)
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image_fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Contenido principal (columna con botón volver, título y lista)
              Column(
                children: [
                  // Botón volver debajo del navbar (mantenemos la misma lógica)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(
                              userName: "Usuario",
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Título centrado
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Historial de Medicamentos",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Área principal: lista o mensaje
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Builder(builder: (context) {
                        if (mostrarPopupInicial) {
                          // Si está el popup inicial NO mostramos la lista debajo (el popup se renderiza en overlay)
                          return const SizedBox.shrink();
                        }

                        if (medicamentos.isEmpty) {
                          return const Center(
                            child: Text(
                              "Agrega un medicamento para empezar tu historial.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 34, 34),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        // Lista de medicamentos
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 0, bottom: 32),
                          itemCount: medicamentos.length,
                          itemBuilder: (context, index) {
                            final med = medicamentos[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                title: Text(med["nombre"] ?? "Medicamento"),
                                subtitle: Text(med["dosis"] ?? "Dosis no definida"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicationDetailView(medicamento: med),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),

              // ---------- Popup inicial (overlay) ----------
              if (mostrarPopupInicial) ...[
                // oscurece el fondo del area del child
                Positioned.fill(
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),

                // tarjeta emergente central
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cancel,
                              size: 50,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "¡Aún no tienes historial de medicamento!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Añade uno a tu historial",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _abrirAddView,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3CAC6B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              ),
                              child: const Text(
                                "Agregar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                mostrarPopupInicial = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // ---------- FloatingActionButton personalizado (dentro del child) ----------
              if (!mostrarPopupInicial)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFF3CAC6B),
                    onPressed: _abrirAddView,
                    child: const Icon(Icons.add),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}












  

