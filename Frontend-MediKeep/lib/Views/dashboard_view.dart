import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ✅ Importa el nuevo widget unificado
import '../Widgets/navbar_menu.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _getuser(widget.userName).then((success) {});
  }

  String name = "";
  String id = "";
  final String apiUrl = 'http://localhost:3001/api/usuario';

  Future<void> _getuser(String userName) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl + '/correo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'correo': userName}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          name = responseData['nombre'];
          id = responseData['_id'];
        });
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Lista temporal de medicamentos (más adelante vendrá de la BD)
  final List<Map<String, String>> _medicamentos = []; // ← Vacía por ahora

  @override
  Widget build(BuildContext context) {
    return NavBarMenu(
      id: id,
      userName: name, // ✅ Muestra el usuario en el header
      child: Stack(
        children: [
          // ---------------- Fondo con imagen ----------------
          Positioned.fill(
            child: Image.asset(
              "assets/images/image_fondo.png",
              fit: BoxFit.cover,
            ),
          ),

          // ---------------- Contenido principal ----------------
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),

                // ---------------- Título (Hola, Usuario) ----------------
                Text(
                  "Hola, ${widget.userName}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // ---------------- Calendario ----------------
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        return _buildDayContent(day);
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return _buildDayCircle(
                          dayNumber: day.day,
                          fillColor: Colors.blue,
                          textColor: Colors.white,
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return _buildDayCircle(
                          dayNumber: day.day,
                          fillColor: Colors.blue,
                          textColor: Colors.white,
                        );
                      },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ---------------- Subtítulo ----------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Tus medicamentos para hoy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ---------------- Lista dinámica ----------------
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      if (_medicamentos.isNotEmpty)
                        ..._medicamentos.map((med) {
                          return _buildMedicineCard(
                            med["nombre"]!,
                            med["hora"]!,
                          );
                        })
                      else
                        // ✅ Mensaje cuando no hay medicamentos
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/capsule_incon.svg",
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "No tienes medicamentos para este día (${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year})",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Helpers del calendario ----------------
  Widget _buildDayContent(DateTime day) {
    return Center(
      child: Text('${day.day}', style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildDayCircle({
    required int dayNumber,
    required Color fillColor,
    required Color textColor,
  }) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
        child: Text(
          '$dayNumber',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ---------------- Tarjeta de medicamento (solo UI) ----------------
  Widget _buildMedicineCard(String name, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.9),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/capsule_incon.svg",
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}
