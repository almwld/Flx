import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.darkBackground, AppTheme.darkSurface])),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 150, height: 150, decoration: BoxDecoration(gradient: const RadialGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]), borderRadius: BorderRadius.circular(40)),
              child: const Icon(Icons.shopping_bag, size: 80, color: Colors.black)),
            const SizedBox(height: 30),
            const Text('FLEX', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
            const Text('YEMEN', style: TextStyle(fontSize: 24, color: AppTheme.goldLight)),
            const SizedBox(height: 40),
            const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldColor)),
          ]),
        ),
      ),
    );
  }
}
