import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/supabase_service.dart';

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

    try {
      // 1. رفع الصور إلى Supabase Storage
      List<String> imagePaths = _selectedImages.map((f) => f.path).toList();
      List<String> uploadedUrls = await SupabaseService.uploadMultipleImages(
        filePaths: imagePaths,
        bucket: 'ads',
      );

      // 2. إضافة الإعلان إلى قاعدة البيانات
      await SupabaseService.addProduct({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'currency': 'YER',
        'images': uploadedUrls,
        'category': _selectedCategory,
        'sub_category': '',
        'city': _selectedCity,
        'in_stock': true,
        'is_featured': false,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم نشر الإعلان بنجاح'), backgroundColor: AppTheme.success),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: AppTheme.error),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إضافة إعلان'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 120.h,
                child: _selectedImages.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildImageButton(Icons.photo_library, 'المعرض', _pickImages),
                          SizedBox(width: 24.w),
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
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _titleController,
                label: 'عنوان الإعلان',
                prefixIcon: Icons.title,
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text('اختر الفئة'),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r))),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: Text('اختر المدينة'),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r))),
                items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCity = v),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _priceController,
                label: 'السعر',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _descriptionController,
                label: 'الوصف',
                prefixIcon: Icons.description,
                maxLines: 5,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'نشر الإعلان',
                onPressed: _isLoading ? null : _submitAd,
                isLoading: _isLoading,
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
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32.r, color: AppTheme.goldColor),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.add_photo_alternate, size: 40.r, color: Colors.grey),
      ),
    );
  }

  Widget _buildImagePreview(File image, int index) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedImages.removeAt(index));
            },
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Icon(Icons.close, size: 16.r, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
