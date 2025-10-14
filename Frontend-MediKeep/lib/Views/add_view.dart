import 'package:flutter/material.dart';
import 'package:flutter_medikeep_1/Utils/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Widgets/navbar_menu.dart'; 

class AddView extends StatefulWidget {
  final String id ;
  const AddView({super.key, required this.id});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  String? dosisSeleccionada;
  String? frecuenciaSeleccionada;
  String? duracionSeleccionada;
  TimeOfDay? horaSeleccionada;
  bool usoProlongado = false;
  String userName = "";

  @override
  void initState() {
    super.initState();
    _getuser();
       // Traer medicamentos al iniciar la pantalla
  }

  Future<void> _seleccionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: horaSeleccionada ?? TimeOfDay.now(),
    );
    if (picked != null && picked != horaSeleccionada) {
      setState(() {
        horaSeleccionada = picked;
      });
    }
  }

  // función para hacer la petición POST
  Future<void> _guardarMedicamento(String id) async {
    if (nombreController.text.isEmpty ||
        descripcionController.text.isEmpty ||
        dosisSeleccionada == null ||
        frecuenciaSeleccionada == null ||
        horaSeleccionada == null ||
        (!usoProlongado && duracionSeleccionada == null)) {

      // Mensaje si faltan campos obligatorios
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, complete todos los campos obligatorios."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Datos a enviar a la base de datos
    final medicamentoData = {
      "idUsuario": id, 
      "nombre": nombreController.text,
      "descripcion": descripcionController.text,
      "dosis": dosisSeleccionada,
      "frecuencia": frecuenciaSeleccionada,
      "horaInicio": horaSeleccionada!.format(context),
      "duracion": usoProlongado ? null : duracionSeleccionada, //  si es prolongado, no enviamos duración
      "usoProlongado": usoProlongado,
      "estado": "activo",
      "fecha": DateTime.now().toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse('${Config.serverUrl}medicamento'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(medicamentoData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Medicamento guardado correctamente."),
            backgroundColor: Colors.green,
          ),
        );

        // Redirigimos al historial pasando el medicamento
        Navigator.pushReplacementNamed(
          context,
          "/history",
          arguments: id,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al guardar: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error de conexión: $e"),
          backgroundColor: Colors.red,
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return NavBarMenu(
      id: widget.id,
      userName: userName, // ✅ mismo estilo que ProfileView
      showBack: true,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image_fondo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Agregar Medicamento",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Nombre*"),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    hintText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Descripción*"),
                TextField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Descripción del medicamento o motivo",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Dosis*"),
                DropdownButtonFormField<String>(
                  value: dosisSeleccionada,
                  items: [
                    "1 tableta",
                    "2 tabletas",
                    "3 tabletas",
                    "4 tabletas",
                    "5 tabletas",
                  ].map((opcion) {
                    return DropdownMenuItem(
                      value: opcion,
                      child: Text(opcion),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      dosisSeleccionada = valor;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Frecuencia*"),
                DropdownButtonFormField<String>(
                  value: frecuenciaSeleccionada,
                  items: [
                    "4 horas",
                    "6 horas",
                    "8 horas",
                    "12 horas",
                    "24 horas",
                    "48 horas",
                    "72 horas",
                  ].map((opcion) {
                    return DropdownMenuItem(
                      value: opcion,
                      child: Text(opcion),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      frecuenciaSeleccionada = valor;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("Hora*"),
                InkWell(
                  onTap: () => _seleccionarHora(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      horaSeleccionada != null
                          ? horaSeleccionada!.format(context)
                          : "Seleccionar hora",
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (!usoProlongado) ...[
                  const Text("Duración*"),
                  DropdownButtonFormField<String>(
                    value: duracionSeleccionada,
                    items: [
                      "5 días",
                      "7 días",
                      "10 días",
                      "15 días",
                      "30 días",
                    ].map((opcion) {
                      return DropdownMenuItem(
                        value: opcion,
                        child: Text(opcion),
                      );
                    }).toList(),
                    onChanged: (valor) {
                      setState(() {
                        duracionSeleccionada = valor;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                Row(
                  children: [
                    Checkbox(
                      value: usoProlongado,
                      onChanged: (valor) {
                        setState(() {
                          usoProlongado = valor ?? false;
                          if (usoProlongado) {
                            duracionSeleccionada = null; // 👈 limpiamos duración
                          }
                        });
                      },
                    ),
                    const Text("Medicamento de uso prolongado"),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón Guardar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                       await _guardarMedicamento(widget.id);
                       },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Guardar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}














  
