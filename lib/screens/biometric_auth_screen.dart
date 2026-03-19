import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  bool _useBiometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'المصادقة البيومترية'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('استخدام البصمة أو Face ID لتسجيل الدخول'),
              value: _useBiometric,
              onChanged: (v) => setState(() => _useBiometric = v),
              secondary: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
            ),
            if (_useBiometric) ...[
              const SizedBox(height: 30),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.fingerprint, size: 60, color: AppTheme.goldColor),
              ),
              const SizedBox(height: 20),
              const Text('اضغط لتفعيل البصمة', style: TextStyle(fontFamily: 'Changa')),
              const SizedBox(height: 20),
              CustomButton(
                text: 'تفعيل',
                onPressed: () {},
              ),
            ],
          ],
        ),
      ),
    );
  }
}
