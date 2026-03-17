import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedCity;
  List<File> _selectedImages = [];
  bool _isLoading = false;

  final List<String> _categories = [
    'سيارات', 'عقارات', 'إلكترونيات', 'أثاث', 'ملابس', 'مطاعم', 'خدمات', 'أخرى'
  ];

  final List<String> _cities = [
    'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'سيئون', 'ذمار'
  ];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _submitAd() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إضافة صورة'), backgroundColor: AppTheme.error),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نشر الإعلان'), backgroundColor: AppTheme.success),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إضافة إعلان'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 120,
                child: _selectedImages.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildImageButton(Icons.photo_library, 'المعرض', _pickImages),
                          const SizedBox(width: 24),
                          _buildImageButton(Icons.camera_alt, 'الكاميرا', _takePhoto),
                        ],
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _selectedImages.length) {
                            return _buildAddMoreButton();
                          }
                          return _buildImagePreview(_selectedImages[index], index);
                        },
                      ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان الإعلان',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text('اختر الفئة'),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: (v) => v == null ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: const Text('اختر المدينة'),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCity = v),
                validator: (v) => v == null ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'السعر',
                  suffixText: 'ر.ي',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAd,
                  child: _isLoading 
                      ? const CircularProgressIndicator() 
                      : const Text('نشر الإعلان', style: TextStyle(fontFamily: 'Changa', fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: AppTheme.goldColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontFamily: 'Changa')),
        ],
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildImagePreview(File image, int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedImages.removeAt(index));
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
