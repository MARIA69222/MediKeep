import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Función mock similar a la del widget RegisterView
Future<bool> registerMock(Map<String, dynamic> data, http.Client client) async {
  const String apiUrl = '   https://medikeep.onrender.com//api/usuario';
  try {
    final response = await client.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data),
    );

    return response.statusCode == 201; // éxito al crear usuario
  } catch (e) {
    return false;
  }
}

// Mock del cliente HTTP
class MockClient extends http.BaseClient {
  final Map<String, dynamic> mockResponse;
  final int statusCode;

  MockClient({required this.mockResponse, required this.statusCode});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = jsonEncode(mockResponse);
    final stream = http.ByteStream.fromBytes(utf8.encode(response));
    return http.StreamedResponse(stream, statusCode);
  }
}

void main() {
  group('Pruebas unitarias de registro', () {
    test('Debe retornar true cuando el registro es exitoso', () async {
      final client = MockClient(mockResponse: {'message': 'Usuario creado'}, statusCode: 201);

      final userData = {
        'nombre': 'Camila',
        'correo': 'camila@example.com',
        'contrasena': '123456',
        'numeroDocumento': '123456789',
        'telefono': '3001234567',
        'fechaNacimiento': '1995-05-20',
        'apellido': 'Rodriguez',
        'tipoDocumento': 'cc',
        'enfermedad': '',
        'fotoPerfil': ''
      };

      final resultado = await registerMock(userData, client);
      expect(resultado, true);
    });

    test('Debe retornar false cuando el registro falla', () async {
      final client = MockClient(mockResponse: {'error': 'Datos inválidos'}, statusCode: 400);

      final userData = {
        'nombre': '',
        'correo': '',
        'contrasena': '',
      };

      final resultado = await registerMock(userData, client);
      expect(resultado, false);
    });
  });
}
