import 'package:flutter/material.dart';
import '../Widgets/success_dialog.dart'; 
import '../Widgets/navbar_menu.dart'; // ✅ usamos el navbar unificado

class AddView extends StatefulWidget {
  const AddView({super.key});

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

  @override
  Widget build(BuildContext context) {
    return NavBarMenu(
      userName: "Maria", // ✅ mismo estilo que ProfileView
      showBack: true,    // ✅ mantiene botón atrás
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

                // Campos de formulario
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
                  // <-- reemplazado value: por initialValue:
                  initialValue: dosisSeleccionada,
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
                  // <-- reemplazado value: por initialValue:
                  initialValue: frecuenciaSeleccionada,
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

                const Text("Duración*"),
                DropdownButtonFormField<String>(
                  // <-- reemplazado value: por initialValue:
                  initialValue: duracionSeleccionada,
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

                Row(
                  children: [
                    Checkbox(
                      value: usoProlongado,
                      onChanged: (valor) {
                        setState(() {
                          usoProlongado = valor ?? false;
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
                    onPressed: () {
                      final parentContext = context;

                      final nuevoMedicamento = {
                        "nombre": nombreController.text,
                        "descripcion": descripcionController.text,
                        "dosis": dosisSeleccionada,
                        "frecuencia": frecuenciaSeleccionada,
                        "hora": horaSeleccionada?.format(context),
                        "duracion": duracionSeleccionada,
                        "usoProlongado": usoProlongado,
                      };

                      showDialog(
                        context: context,
                        builder: (context) => SuccessDialog(
                          title: "¡Medicamento guardado!",
                          message: "Se ha añadido correctamente a tu lista",
                          onAccept: () {
                            Navigator.pushReplacementNamed(
                              parentContext,
                              "/history",
                              arguments: nuevoMedicamento,
                            );
                          },
                        ),
                      );
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











  
