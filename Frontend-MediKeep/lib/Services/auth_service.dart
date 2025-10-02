
import 'dart:convert';                       
// 'dart:convert' nos permite:
// - Convertir un Map de Dart en un JSON string (jsonEncode)
// - Convertir un JSON string en un Map de Dart (jsonDecode)

import 'package:http/http.dart' as http;     
// Paquete oficial para hacer peticiones HTTP en Dart/Flutter.
// Lo renombramos como "http" para usarlo así: http.post, http.get, etc.


// =============================
// Clase principal de servicio
// =============================
// Aquí se centralizan TODAS las llamadas al backend relacionadas
// con autenticación y gestión del usuario.
// Es buena práctica mantener la lógica de red separada de la UI.
class AuthService {

  // -------------------------------
  // URL base de la API
  // -------------------------------
  // ⚠️ IMPORTANTE: cámbiala por la dirección real de tu backend.
  // Ejemplo local: "http://127.0.0.1:8000/api"
  // Ejemplo en producción: "https://tuservidor.com/api"
  static const String baseUrl = "http://-servidor.com/api";


  // =====================================================================
  // MÉTODO: Registrar usuario
  // =====================================================================
  Future<bool> registerUser({
    // Estos parámetros son obligatorios porque usamos "required"
    required String nombre,
    required String apellido,
    required String fechaNacimiento,
    required String tipoDocumento,
    required String numeroDocumento,
    required String correo,
    required String telefono,
    required String password,
  }) async {

    // Construimos la URL final para registrar
    final url = Uri.parse("$baseUrl/register");

    try {
      // Hacemos la petición POST (crear recurso)
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", // Indicamos que enviamos JSON
        },
        body: jsonEncode({  // Convertimos los datos a JSON
          "nombre": nombre,
          "apellido": apellido,
          "fecha_nacimiento": fechaNacimiento,
          "tipo_documento": tipoDocumento,
          "numero_documento": numeroDocumento,
          "correo": correo,
          "telefono": telefono,
          "password": password,
        }),
      );

      // Revisamos si el servidor respondió con éxito
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 200 = OK, 201 = Created
        return true;
      } else {
        // Si fue 400, 500, etc.
        return false;
      }
    } catch (e) {
      // Si ocurre un error de conexión o excepción
      return false;
    }
  }


  // =====================================================================
  // MÉTODO: Iniciar sesión
  // =====================================================================
  Future<bool> loginUser({
    required String correo,    
    required String password,  
  }) async {

    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo": correo,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Aquí podrías guardar el token que envía el servidor
        // usando SharedPreferences o SecureStorage.
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  // =====================================================================
  // MÉTODO: Cerrar sesión
  // =====================================================================
  Future<bool> logoutUser({required String token}) async {
    final url = Uri.parse("$baseUrl/logout");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Enviamos token del usuario
        },
      );

      if (response.statusCode == 200) {
        // Aquí deberías eliminar el token del dispositivo
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  // =====================================================================
  // MÉTODO: Actualizar perfil de usuario
  // =====================================================================
  Future<bool> updateUser({
    required String token,          // Token del usuario autenticado
    required String nombre,
    required String apellido,
    required String fechaNacimiento,
    required String telefono,
    required String edad,
    required String enfermedad,
  }) async {
    
    // Construimos la URL para actualizar el perfil
    final url = Uri.parse("$baseUrl/update-profile"); 
    // ⚠️ Ajusta la ruta según tu backend (/user/update o /profile/edit)

    try {
      // Hacemos una petición PUT (actualización de recurso existente)
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ⚡ Se requiere autenticación
        },
        body: jsonEncode({
          "nombre": nombre,
          "apellido": apellido,
          "fecha_nacimiento": fechaNacimiento,
          "telefono": telefono,
          "edad": edad,
          "enfermedad": enfermedad,
        }),
      );

      // Revisamos la respuesta del servidor
      if (response.statusCode == 200) {
        return true;  // Perfil actualizado con éxito
      } else {
        return false; // Error en el servidor (400, 500, etc.)
      }
    } catch (e) {
      // Si ocurre un error de conexión
      return false;
    }
  }

} // 👈 Aquí cierra la clase AuthService





