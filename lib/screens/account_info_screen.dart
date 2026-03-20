import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/supabase_service.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});
  @override State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool _isEditing = false; bool _isLoading = false; final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(); final _phoneController = TextEditingController(); final _addressController = TextEditingController();
  String? _avatarUrl; File? _newAvatar; Map<String, dynamic>? _userData;

  @override void initState() { super.initState(); _loadUserData(); }
  Future<void> _loadUserData() async {
    final user = SupabaseService.currentUser; if (user == null) return;
    final profile = await SupabaseService.getUserProfile(user.id);
    if (profile != null) { _userData = profile; _nameController.text = profile['full_name'] ?? ''; _phoneController.text = profile['phone'] ?? ''; _addressController.text = profile['address'] ?? ''; _avatarUrl = profile['avatar_url']; }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) setState(() => _newAvatar = File(f.path));
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return; setState(() => _isLoading = true);
    try {
      final user = SupabaseService.currentUser; if (user == null) throw Exception('مستخدم غير مسجل');
      String? newAvatarUrl = _avatarUrl;
      if (_newAvatar != null) { newAvatarUrl = await SupabaseService.uploadImage(filePath: _newAvatar!.path, bucket: 'avatars', fileName: 'user_${user.id}.jpg'); }
      await SupabaseService.updateUserData(user.id, {'full_name': _nameController.text, 'phone': _phoneController.text, 'address': _addressController.text, 'avatar_url': newAvatarUrl});
      setState(() { _isEditing = false; _avatarUrl = newAvatarUrl; _newAvatar = null; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الحفظ'), backgroundColor: AppTheme.success));
    } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e'), backgroundColor: AppTheme.error)); }
    finally { setState(() => _isLoading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'معلومات الحساب', actions: [
        IconButton(icon: Icon(_isEditing ? Icons.check : Icons.edit), onPressed: () { if (_isEditing) _saveChanges(); else setState(() => _isEditing = true); })
      ]),
      body: _userData == null ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(key: _formKey, child: Column(children: [
          Center(child: Stack(children: [
            Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle,
              image: _newAvatar != null ? DecorationImage(image: FileImage(_newAvatar!), fit: BoxFit.cover) : (_avatarUrl != null ? DecorationImage(image: NetworkImage(_avatarUrl!), fit: BoxFit.cover) : null),
              gradient: (_newAvatar == null && _avatarUrl == null) ? const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]) : null),
              child: (_newAvatar == null && _avatarUrl == null) ? const Icon(Icons.person, size: 50, color: Colors.black) : null),
            if (_isEditing) Positioned(bottom: 0, right: 0, child: GestureDetector(onTap: _pickImage,
              child: Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, size: 20, color: Colors.black))))
          ])), const SizedBox(height: 30),
          CustomTextField(controller: _nameController, label: 'الاسم الكامل', enabled: _isEditing, validator: (v) => v!.isEmpty ? 'مطلوب' : null),
          const SizedBox(height: 16),
          CustomTextField(controller: _phoneController, label: 'رقم الهاتف', enabled: _isEditing, keyboardType: TextInputType.phone, validator: (v) => v!.isEmpty ? 'مطلوب' : null),
          const SizedBox(height: 16),
          CustomTextField(controller: _addressController, label: 'العنوان', enabled: _isEditing, validator: (v) => v!.isEmpty ? 'مطلوب' : null),
          if (_isEditing) ...[ const SizedBox(height: 30), CustomButton(text: 'حفظ التغييرات', onPressed: _saveChanges, isLoading: _isLoading) ],
        ])),
      ),
    );
  }
}
