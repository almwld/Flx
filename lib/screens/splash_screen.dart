import '../models/rating_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0A0A0F),
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFF4E4BC)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(Icons.shopping_bag, size: 80, color: Colors.black),
              ),
              const SizedBox(height: 30),
              const Column(
                children: [
                  Text('FLEX', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37), letterSpacing: 8, fontFamily: 'Changa')),
                  Text('YEMEN', style: TextStyle(fontSize: 24, color: Color(0xFFF4E4BC), letterSpacing: 12, fontFamily: 'Changa')),
                ],
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
