import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/supabase_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await SupabaseService.resetPassword(_emailController.text.trim());
      setState(() { _emailSent = true; _isLoading = false; });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نسيت كلمة المرور'), backgroundColor: AppTheme.goldColor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _emailSent
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(Icons.mark_email_read, size: 80, color: AppTheme.goldColor),
                SizedBox(height: 20),
                Text('تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني.'),
              ])
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                      validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _sendResetEmail,
                      child: _isLoading ? const CircularProgressIndicator() : const Text('إرسال'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
