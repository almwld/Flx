import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'terms_screen.dart';
import 'privacy_policy_screen.dart';
import '../services/supabase_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  String _userType = 'customer'; // 'customer' or 'merchant'
  bool _agreeToTerms = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على الشروط والأحكام'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // استخدام رقم الموبايل كبريد إلكتروني مؤقت (يمكن تحسينه لاحقاً)
      final email = '${_phoneController.text}@temp.com';
      
      final response = await SupabaseService.signUpWithEmail(
        email: email,
        password: _passwordController.text,
        data: {
          'full_name': _nameController.text,
          'phone': _phoneController.text,
          'user_type': _userType,
        },
      );

      if (response.user != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء الحساب بنجاح، يرجى تفعيل البريد الإلكتروني'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          backgroundColor: AppTheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إنشاء حساب جديد'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'أدخل بياناتك لإنشاء حساب جديد',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // اختيار نوع المستخدم (تاجر / عميل)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _userType = 'merchant'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _userType == 'merchant'
                                ? AppTheme.goldColor
                                : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _userType == 'merchant'
                                  ? AppTheme.goldColor
                                  : Colors.grey.shade400,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'نقطة مبيعات',
                              style: TextStyle(
                                color: _userType == 'merchant'
                                    ? Colors.black
                                    : (isDark ? Colors.white : Colors.black87),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _userType = 'customer'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _userType == 'customer'
                                ? AppTheme.goldColor
                                : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _userType == 'customer'
                                  ? AppTheme.goldColor
                                  : Colors.grey.shade400,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'عميل',
                              style: TextStyle(
                                color: _userType == 'customer'
                                    ? Colors.black
                                    : (isDark ? Colors.white : Colors.black87),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // الاسم الكامل
              CustomTextField(
                controller: _nameController,
                label: 'الاسم الكامل',
                prefixIcon: Icons.person_outline,
                validator: (v) => v!.isEmpty ? 'الاسم مطلوب' : null,
              ),
              const SizedBox(height: 16),

              // رقم الموبايل
              CustomTextField(
                controller: _phoneController,
                label: 'رقم الموبايل',
                prefixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v!.isEmpty) return 'رقم الموبايل مطلوب';
                  if (v.length < 10) return 'رقم غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // كلمة المرور
              CustomTextField(
                controller: _passwordController,
                label: 'كلمة المرور',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
                onSuffixPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                validator: (v) {
                  if (v!.isEmpty) return 'كلمة المرور مطلوبة';
                  if (v.length < 6) return 'كلمة المرور قصيرة (6 أحرف على الأقل)';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // تأكيد كلمة المرور
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'تأكيد كلمة المرور',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureConfirmPassword,
                suffixIcon: _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                onSuffixPressed: () {
                  setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                },
                validator: (v) {
                  if (v!.isEmpty) return 'تأكيد كلمة المرور مطلوب';
                  if (v != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // الموافقة على الشروط
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (v) => setState(() => _agreeToTerms = v ?? false),
                    activeColor: AppTheme.goldColor,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _agreeToTerms = !_agreeToTerms),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                          children: [
                            const TextSpan(text: 'أوافق على '),
                            TextSpan(
                              text: 'الشروط والأحكام',
                              style: const TextStyle(
                                color: AppTheme.goldColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TermsScreen()),
                                  );
                                },
                            ),
                            const TextSpan(text: ' و '),
                            TextSpan(
                              text: 'سياسة الخصوصية',
                              style: const TextStyle(
                                color: AppTheme.goldColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // زر إنشاء حساب
              CustomButton(
                text: 'إنشاء حساب',
                onPressed: _register,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),

              // رابط تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('لديك حساب بالفعل؟'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: AppTheme.goldColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
