import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'محمد أحمد');
  final _emailController = TextEditingController(text: 'mohammed@email.com');
  final _phoneController = TextEditingController(text: '777123456');
  final _addressController = TextEditingController(text: 'صنعاء - شارع حدة');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'معلومات الحساب',
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isEditing = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ التغييرات')),
                  );
                }
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // الصورة الشخصية
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 50, color: Colors.black),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, size: 20, color: Colors.black),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // الحقول
              CustomTextField(
                controller: _nameController,
                label: 'الاسم الكامل',
                prefixIcon: Icons.person_outline,
                enabled: _isEditing,
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'البريد الإلكتروني',
                prefixIcon: Icons.email_outlined,
                enabled: _isEditing,
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                label: 'رقم الهاتف',
                prefixIcon: Icons.phone_outlined,
                enabled: _isEditing,
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _addressController,
                label: 'العنوان',
                prefixIcon: Icons.location_on_outlined,
                enabled: _isEditing,
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              
              if (_isEditing) ...[
                const SizedBox(height: 30),
                CustomButton(
                  text: 'تغيير كلمة المرور',
                  onPressed: () {},
                  isOutlined: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
