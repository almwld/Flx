import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import 'main_navigation.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); final _emailController = TextEditingController(); final _passwordController = TextEditingController();
  bool _isLoading = false; bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return; setState(() => _isLoading = true);
    try {
      await SupabaseService.signInWithEmail(_emailController.text.trim(), _passwordController.text);
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigation()));
    } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل تسجيل الدخول: $e'), backgroundColor: AppTheme.error)); }
    finally { if (mounted) setState(() => _isLoading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 40),
            Container(width: 100, height: 100, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]), shape: BoxShape.circle),
              child: const Icon(Icons.shopping_bag, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text('مرحباً بك في Flex Yemen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('سجل دخول للمتابعة', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 40),
            TextFormField(controller: _emailController, decoration: InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: const Icon(Icons.email_outlined), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              validator: (v) => v!.isEmpty ? 'مطلوب' : null),
            const SizedBox(height: 16),
            TextFormField(controller: _passwordController, obscureText: _obscurePassword,
              decoration: InputDecoration(labelText: 'كلمة المرور', prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              validator: (v) => v!.isEmpty ? 'مطلوب' : null),
            Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
              child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: AppTheme.goldColor)))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _login,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: _isLoading ? const CircularProgressIndicator(color: Colors.black) : const Text('تسجيل الدخول', style: TextStyle(fontSize: 16)))),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('ليس لديك حساب؟'),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: const Text('إنشاء حساب', style: TextStyle(color: AppTheme.goldColor))),
            ]),
            const SizedBox(height: 8),
            TextButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigation(isGuest: true))),
              child: const Text('الدخول كضيف', style: TextStyle(color: Colors.grey))),
          ]),
        ),
      ),
    );
  }
}
