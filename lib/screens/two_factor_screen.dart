import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class TwoFactorScreen extends StatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  bool _isEnabled = false;
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'المصادقة الثنائية'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('تفعيل المصادقة الثنائية'),
              value: _isEnabled,
              onChanged: (v) => setState(() => _isEnabled = v),
              secondary: const Icon(Icons.lock, color: AppTheme.goldColor),
            ),
            if (_isEnabled) ...[
              const SizedBox(height: 20),
              const Text('أدخل الرقم المرسل إلى هاتفك', style: TextStyle(fontFamily: 'Changa')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (i) => SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _controllers[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                )),
              ),
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
