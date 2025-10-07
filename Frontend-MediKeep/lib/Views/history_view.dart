// Vista: Historial de Medicamentos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Importamos las pantallas relacionadas.
import 'dashboard_view.dart'; // Pantalla principal (DashboardScreen)
import 'add_view.dart'; // Pantalla para agregar medicamento (AddView)
import 'medication_detail_view.dart'; // Pantalla de detalle de medicamento

// Importamos el nuevo Navbar
import '../Widgets/navbar_menu.dart';

class HistoryView extends StatefulWidget {
  final String id ;
  const HistoryView({super.key, required this.id});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Map<String, dynamic>> medicamentos = [];
  bool mostrarPopupInicial = true; // Solo se muestra si NO hay medicamentos

  @override
  void initState() {
    super.initState();
    _fetchMedicamentos(widget.id); // Traer medicamentos al iniciar la pantalla
  }

  // Función GET para obtener los medicamentos del usuario
  Future<void> _fetchMedicamentos( String userId) async {
    final url = Uri.parse('http://localhost:3001/api/medicamento/usuario/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          medicamentos = data.map((e) => e as Map<String, dynamic>).toList();
          // Solo mostrar popup si la lista está vacía
          mostrarPopupInicial = medicamentos.isEmpty;
        });
      } else {
        print('Error al cargar medicamentos: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción al obtener medicamentos: $e');
    }
  }

  // Función que abre AddView y actualiza la lista al regresar
  Future<void> _abrirAddView() async {
    final nuevoMedicamento = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddView(id: widget.id)),
    );

    // Si se agregó un medicamento, recargamos la lista completa desde la API
    if (nuevoMedicamento != null) {
      _fetchMedicamentos(widget.id); // Refresca automáticamente el historial
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavBarMenu(
      id: widget.id,
      userName: "Usuario",
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
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                              userName: "Usuario",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Historial de Medicamentos",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Builder(builder: (context) {
                        // Si no hay medicamentos y se debe mostrar popup
                        if (mostrarPopupInicial) {
                          return const SizedBox.shrink();
                        }

                        // Si la lista está vacía, mensaje estático (no popup)
                        if (medicamentos.isEmpty) {
                          return const Center(
                            child: Text(
                              "Agrega un medicamento para empezar tu historial.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 1, 1),
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
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8), // margen entre cajones
                              child: Card(
                                color: Colors.white, // cajón completamente blanco
                                elevation: 15, // sombra para profundidad
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.grey, width: 1), // contorno
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  title: Text(
                                    med["nombre"] ?? "Medicamento",
                                    style: const TextStyle(
                                      color: Colors.black, // letra negra
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    med["dosis"] ?? "Dosis no definida",
                                    style: const TextStyle(
                                      color: Colors.black, // letra negra
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MedicationDetailView(medicamento: med , id: widget.id),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),

              // ---------- Popup inicial solo si no hay medicamentos ----------
              if (mostrarPopupInicial && medicamentos.isEmpty) ...[
                Positioned.fill(
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
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

              // FloatingActionButton
              if (!mostrarPopupInicial)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 99, 185, 135),
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














  

