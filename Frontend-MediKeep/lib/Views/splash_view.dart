import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_medikeep_1/Views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Espera 2 segundos y luego navega a LoginView
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image_fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo centrado
          Center(
            child: Image.asset(
              'assets/images/MediKepp_logo.png',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}


