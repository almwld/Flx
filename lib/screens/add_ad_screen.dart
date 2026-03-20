import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/supabase_service.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});
  @override State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final _formKey = GlobalKey<FormState>(); final _titleController = TextEditingController(); final _descController = TextEditingController(); final _priceController = TextEditingController();
  String? _category; String? _city; List<File> _images = []; bool _isLoading = false;
  final List<String> _categories = ['سيارات', 'عقارات', 'إلكترونيات', 'أثاث', 'ملابس', 'خدمات', 'أخرى'];
  final List<String> _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب'];

  Future<void> _pickImages() async {
    final picker = ImagePicker(); final picked = await picker.pickMultiImage();
    if (picked != null) setState(() => _images = picked.map((f) => File(f.path)).toList());
  }

  Future<void> _submit() async {
    if (_images.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أضف صورة على الأقل'), backgroundColor: AppTheme.error)); return; }
    setState(() => _isLoading = true);
    try {
      List<String> urls = await SupabaseService.uploadMultipleImages(filePaths: _images.map((f) => f.path).toList(), bucket: 'ads');
      await SupabaseService.addProduct({
        'title': _titleController.text, 'description': _descController.text, 'price': double.parse(_priceController.text),
        'currency': 'YER', 'images': urls, 'category': _category, 'city': _city, 'in_stock': true,
      });
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الإعلان'), backgroundColor: AppTheme.success)); Navigator.pop(context); }
    } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e'), backgroundColor: AppTheme.error)); }
    finally { if (mounted) setState(() => _isLoading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'إضافة إعلان'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(key: _formKey, child: Column(children: [
          _images.isEmpty
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _buildImageButton(Icons.photo_library, 'المعرض', _pickImages),
                  const SizedBox(width: 24),
                  _buildImageButton(Icons.camera_alt, 'الكاميرا', () async {
                    final picker = ImagePicker(); final f = await picker.pickImage(source: ImageSource.camera);
                    if (f != null) setState(() => _images.add(File(f.path)));
                  }),
                ])
              : SizedBox(height: 120, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _images.length + 1,
                  itemBuilder: (_, i) => i == _images.length
                      ? GestureDetector(onTap: _pickImages, child: Container(width: 100, margin: const EdgeInsets.only(right: 8), color: Colors.grey[300], child: const Icon(Icons.add_photo_alternate, size: 40)))
                      : Stack(children: [
                          Container(width: 100, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(image: DecorationImage(image: FileImage(_images[i]), fit: BoxFit.cover))),
                          Positioned(top: 4, right: 4, child: GestureDetector(onTap: () => setState(() => _images.removeAt(i)),
                            child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.close, size: 16, color: Colors.white))))
                        ]))),
          const SizedBox(height: 24),
          CustomTextField(controller: _titleController, label: 'عنوان الإعلان'),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(value: _category, hint: const Text('الفئة'), items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _category = v), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(value: _city, hint: const Text('المدينة'), items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _city = v), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 16),
          CustomTextField(controller: _priceController, label: 'السعر', prefixIcon: Icons.attach_money, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          CustomTextField(controller: _descController, label: 'الوصف', maxLines: 5),
          const SizedBox(height: 24),
          CustomButton(text: 'نشر الإعلان', onPressed: _submit, isLoading: _isLoading),
        ])),
      ),
    );
  }

  Widget _buildImageButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Column(children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, size: 32, color: AppTheme.goldColor)),
      const SizedBox(height: 8), Text(label, style: const TextStyle(fontFamily: 'Changa')) ]));
  }
}
