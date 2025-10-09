import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Creamos una función de login similar a la de tu widget para probarla
Future<bool> loginMock(String correo, String contrasena, http.Client client) async {
  const String apiUrl = '   https://medikeep.onrender.com//api/usuario/login';
  try {
    final response = await client.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'correo': correo, 'contrasena': contrasena}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['message'] == "";
    } else {
      return false;
    }
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
  group('Pruebas unitarias del login', () {
    test('Debe retornar true cuando el login es exitoso', () async {
      final client = MockClient(mockResponse: {'message': ''}, statusCode: 200);
      final resultado = await loginMock('correo@ejemplo.com', '123456', client);
      expect(resultado, true);
    });

    test('Debe retornar false cuando las credenciales son incorrectas', () async {
      final client = MockClient(
        mockResponse: {'message': 'Revise los datos ingresados'},
        statusCode: 404,
      );
      final resultado = await loginMock('mal@correo.com', 'clave', client);
      expect(resultado, false);
    });
  });
}
