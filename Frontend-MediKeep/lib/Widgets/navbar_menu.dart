// 📦 Importamos Flutter
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 📦 Importamos vistas para navegación desde el menú
import '/views/history_view.dart';
import '/views/login_view.dart';
import '/views/add_view.dart';
import '/views/profile_view.dart';
import '/views/dashboard_view.dart'; // 👈 Import del Dashboard

// 🔹 Widget principal que une Header + Menu
class NavBarMenu extends StatefulWidget {
  final String? userName;
  final String? title;
  final bool showBack;
  final Widget child; // contenido dinámico de cada vista
  final String id; 

  const NavBarMenu({
    super.key,
    this.userName,
    this.title,
    this.showBack = false,
    required this.id,
    required this.child,
    
  });

  @override
  State<NavBarMenu> createState() => _NavBarMenuState();
}

class _NavBarMenuState extends State<NavBarMenu> {
  bool _isMenuOpen = false;
  String id = '';

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      id = widget.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Contenido principal de la vista
          Column(
            children: [
              // Encabezado
              _buildHeader(context),

              // Línea separadora debajo del header
              Container(
                height: 1,
                color: Colors.grey[300],
              ),

              // Contenido dinámico
              Expanded(child: widget.child),
            ],
          ),

          // 🔹 Menú hamburguesa si está abierto
          if (_isMenuOpen)
            MenuHamburguesa(
              onClose: _toggleMenu,
              userName: widget.userName, 
              id: widget.id
            ),
        ],
      ),
    );
  }

  // Header reutilizado
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            )
          else
            Image.asset(
              "assets/images/medikepp_logo.png",
              height: 32,
            ),
          if (widget.title != null)
            Text(
              widget.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            )
          else if (widget.userName != null)
            Row(
              children: [
                Text(
                  widget.userName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _toggleMenu,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    child: SvgPicture.asset(
                      'assets/icons/avatar_icon.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// 🔹 Menú hamburguesa integrado
class MenuHamburguesa extends StatelessWidget {
  final VoidCallback onClose;
  final String? userName; 
  final String id;  

  const MenuHamburguesa({
    super.key,
    required this.onClose,
    this.userName,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black26,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
              right: 16,
            ),
            child: Material(
              color: Colors.white,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 260,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),

                    //  Nuevo botón Inicio
                    _MenuRow(
                      icon: Icons.home,
                      iconColor: const Color(0xFF3CAC6B),
                      text: "Inicio",
                      onTap: () {
                        onClose();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                              userName: userName ?? "Invitado", // aquí pasamos userName
                            ),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1, color: Color(0xFFE6E6E6)),

                    _MenuRow(
                      icon: Icons.person,
                      iconColor: const Color(0xFF3CAC6B),
                      text: "Mi perfil",
                      onTap: () {
                        onClose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ProfileView(id: id),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE6E6E6)),

                    _MenuRow(
                      icon: Icons.add,
                      iconColor: const Color(0xFF3CAC6B),
                      text: "Agregar",
                      onTap: () {
                        onClose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddView(id: id),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE6E6E6)),

                    _MenuRow(
                      icon: Icons.history,
                      iconColor: const Color(0xFF3CAC6B),
                      text: "Historial",
                      onTap: () {
                        onClose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  HistoryView( id: id),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE6E6E6)),

                    _MenuRow(
                      icon: Icons.exit_to_app,
                      iconColor: const Color(0xFFE64A19),
                      text: "Cerrar sesión",
                      onTap: () {
                        onClose();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  LoginView(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 🔹 Item de menú
class _MenuRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onTap;

  const _MenuRow({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: iconColor.withValues(alpha: 0.1),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}



