import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Widgets/navbar_menu.dart';
import 'profile_view.dart';

class EditProfileView extends StatefulWidget {
  final String id;
  const EditProfileView({super.key, required this.id});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  String userName="" ;
  

  @override
  void initState() {
    super.initState();
    _loadUsuario(widget.id);
    _getuser();
  }

  Future<void> _loadUsuario(String userId) async {
    final url = Uri.parse('https://medikeep.onrender.com$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userName = data['correo'];
          nameController.text = data['nombre'] ?? '';
          lastNameController.text = data['apellido'] ?? '';
          birthController.text = data['fechaNacimiento'] ?? '';
          phoneController.text = data['telefono'] ?? '';
          ageController.text = data['fechaNacimiento'] != null
              ? _calcularEdad(data['fechaNacimiento'])
              : '';
          diseaseController.text = data['enfermedad'] ?? '';
        });
      } else {
        print('Error al cargar usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción al obtener usuario: $e');
    }
  }
// getuser
  Future<void> _getuser() async {
    try {
      final response = await http.get(
        Uri.parse('https://medikeep.onrender.com'+ widget.id),
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

  String _calcularEdad(String fechaNacimiento) {
    try {
      final partes = fechaNacimiento.split('/'); // DD/MM/YYYY
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
      return '';
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _guardarCambios() async {
    final userId = widget.id;
    final url = Uri.parse('http://localhost:3001/api/usuario/$userId');

    final body = {
      "nombre": nameController.text,
      "apellido": lastNameController.text,
      "fechaNacimiento": birthController.text,
      "telefono": phoneController.text,
      "enfermedad": diseaseController.text,
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Datos actualizados correctamente"),
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromRGBO(51, 153, 102, 1),
          ),
        );

        // Volver a la vista de perfil después de un corto delay
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(
            context,
            '/dashboard',
            arguments: userName ,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error al actualizar los datos"),
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromRGBO(244, 67, 54, 1),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error de conexión"),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(244, 67, 54, 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    birthController.dispose();
    phoneController.dispose();
    ageController.dispose();
    diseaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    final double avatarRadius = screenWidth * 0.14;
    final double horizontalPadding = screenWidth * 0.06;
    final args = ModalRoute.of(context)?.settings.arguments as String?;

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
                // Botón atrás
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // Avatar
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: const Color.fromRGBO(
                          158,
                          158,
                          158,
                          1.0,
                        ),
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.person,
                                size: avatarRadius * 0.6,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Campos editables
                _buildEditableField(
                  label: "Nombre",
                  controller: nameController,
                  hint: "Nombre",
                ),
                _buildEditableField(
                  label: "Apellido",
                  controller: lastNameController,
                  hint: "Apellido",
                ),
                _buildEditableField(
                  label: "Fecha de nacimiento",
                  controller: birthController,
                  hint: "DD / MM / YYYY",
                ),
                _buildEditableField(
                  label: "Teléfono",
                  controller: phoneController,
                  hint: "Teléfono",
                ),
                _buildEditableField(
                  label: "Edad",
                  controller: ageController,
                  hint: "Edad",
                  readOnly: true,
                ),
                _buildEditableField(
                  label: "Enfermedad",
                  controller: diseaseController,
                  hint: "Enfermedad",
                ),

                SizedBox(height: screenHeight * 0.03),

                // Botón guardar cambios
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7 > 360 ? 360 : screenWidth * 0.7,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _guardarCambios,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(51, 153, 102, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Guardar Cambios",
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

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
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
            controller: controller,
            readOnly: readOnly,
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
