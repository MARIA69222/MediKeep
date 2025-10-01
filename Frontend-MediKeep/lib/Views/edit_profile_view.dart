import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Widgets/navbar_menu.dart';
import '../Widgets/notification_helper.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

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
                // Botón atrás
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // Avatar con icono de cámara
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: const Color.fromRGBO(158, 158, 158, 1.0),
                        backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? Icon(Icons.person, size: avatarRadius * 0.6, color: Colors.white)
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
                            child: const Icon(Icons.camera_alt, size: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Campos editables
                _buildEditableField(label: "Nombre", controller: nameController, hint: "Nombre"),
                _buildEditableField(label: "Apellido", controller: lastNameController, hint: "Apellido"),
                _buildEditableField(label: "Fecha de nacimiento", controller: birthController, hint: "DD / MM / YYYY"),
                _buildEditableField(label: "Teléfono", controller: phoneController, hint: "Teléfono"),
                _buildEditableField(label: "Edad", controller: ageController, hint: "Edad"),
                _buildEditableField(label: "Enfermedad", controller: diseaseController, hint: "Enfermedad"),

                SizedBox(height: screenHeight * 0.03),

                // Botón guardar cambios
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7 > 360 ? 360 : screenWidth * 0.7,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        NotificationHelper.showSuccessDialog(context);
                      },
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
            readOnly: false,
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

 
