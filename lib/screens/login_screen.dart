import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'main_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag, size: 100, color: AppTheme.goldColor),
            const SizedBox(height: 40),
            const Text('مرحباً بك', style: TextStyle(fontFamily: 'Changa', fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('سجل دخول للمتابعة', style: TextStyle(fontFamily: 'Changa', fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'رقم الموبايل',
                prefixIcon: const Icon(Icons.phone_android),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MainNavigation()),
                  );
                },
                child: const Text('تسجيل الدخول', style: TextStyle(fontFamily: 'Changa', fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainNavigation(isGuest: true)),
                );
              },
              child: const Text('الدخول كضيف', style: TextStyle(fontFamily: 'Changa')),
            ),
          ],
        ),
      ),
    );
  }
}
