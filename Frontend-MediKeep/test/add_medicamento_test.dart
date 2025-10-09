import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Función simulada de agregar medicamento (como en AddView)
Future<bool> addMedicamentoMock(Map<String, dynamic> data, http.Client client) async {
  const String apiUrl = '   https://medikeep.onrender.com//api/medicamento';
  try {
    final response = await client.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data),
    );
    return response.statusCode == 201 || response.statusCode == 200;
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
  group('Pruebas unitarias - Agregar medicamento', () {
    test('Debe retornar true cuando el medicamento se guarda correctamente', () async {
      final client = MockClient(
        mockResponse: {'message': 'Medicamento agregado con éxito'},
        statusCode: 201,
      );

      final medicamentoData = {
        "idUsuario": "123abc",
        "nombre": "Paracetamol",
        "descripcion": "Dolor de cabeza",
        "dosis": "1 tableta",
        "frecuencia": "12 horas",
        "horaInicio": "08:00 AM",
        "duracion": "5 días",
        "usoProlongado": false,
        "estado": "activo",
        "fecha": DateTime.now().toIso8601String(),
      };

      final resultado = await addMedicamentoMock(medicamentoData, client);
      expect(resultado, true);
    });

    test('Debe retornar false cuando ocurre un error en el servidor', () async {
      final client = MockClient(
        mockResponse: {'error': 'Error interno'},
        statusCode: 500,
      );

      final medicamentoData = {
        "idUsuario": "123abc",
        "nombre": "Ibuprofeno",
        "descripcion": "Dolor muscular",
      };

      final resultado = await addMedicamentoMock(medicamentoData, client);
      expect(resultado, false);
    });
  });
}
