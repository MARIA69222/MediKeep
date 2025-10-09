import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Función simulada para obtener historial de medicamentos
Future<List<Map<String, dynamic>>> fetchHistorialMock(String idUsuario, http.Client client) async {
  final String apiUrl = '   https://medikeep.onrender.com//api/medicamento/usuario/$idUsuario';
  try {
    final response = await client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

// Mock del cliente HTTP
class MockClient extends http.BaseClient {
  final dynamic mockResponse;
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
  group('Pruebas unitarias - Historial de medicamentos', () {
    test('Debe retornar lista con medicamentos cuando la respuesta es exitosa', () async {
      final client = MockClient(
        mockResponse: [
          {
            "nombre": "Paracetamol",
            "dosis": "1 tableta cada 12h",
            "fechaInicio": "2025-10-01"
          },
          {
            "nombre": "Ibuprofeno",
            "dosis": "1 cápsula cada 8h",
            "fechaInicio": "2025-10-02"
          }
        ],
        statusCode: 200,
      );

      final resultado = await fetchHistorialMock('usuario123', client);
      expect(resultado.isNotEmpty, true);
      expect(resultado.length, 2);
      expect(resultado[0]['nombre'], 'Paracetamol');
    });

    test('Debe retornar lista vacía cuando el usuario no tiene medicamentos', () async {
      final client = MockClient(mockResponse: [], statusCode: 200);
      final resultado = await fetchHistorialMock('usuarioSinDatos', client);
      expect(resultado.isEmpty, true);
    });

    test('Debe retornar lista vacía si ocurre un error del servidor', () async {
      final client = MockClient(mockResponse: {'error': 'Error interno'}, statusCode: 500);
      final resultado = await fetchHistorialMock('usuarioError', client);
      expect(resultado.isEmpty, true);
    });
  });
}
