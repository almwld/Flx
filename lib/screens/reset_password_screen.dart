import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/supabase_service.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await SupabaseService.updateUserProfile({
        'password': _passwordController.text,
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تغيير كلمة المرور بنجاح'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تعيين كلمة مرور جديدة'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'أدخل كلمة المرور الجديدة',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'كلمة المرور الجديدة',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
                onSuffixPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                validator: (v) {
                  if (v == null || v.isEmpty) return 'مطلوب';
                  if (v.length < 6) return '6 أحرف على الأقل';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmController,
                label: 'تأكيد كلمة المرور',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureConfirm,
                suffixIcon: _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                onSuffixPressed: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
                validator: (v) {
                  if (v == null || v.isEmpty) return 'مطلوب';
                  if (v != _passwordController.text) return 'غير متطابقة';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'تحديث كلمة المرور',
                onPressed: _updatePassword,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
