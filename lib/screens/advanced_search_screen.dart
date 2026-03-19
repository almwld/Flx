import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final _keywordController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 1000000);
  String? _selectedCategory;
  String? _selectedCity;
  bool _withImages = false;

  final List<String> _categories = ['الكل', 'إلكترونيات', 'أثاث', 'سيارات', 'عقارات'];
  final List<String> _cities = ['الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'بحث متقدم'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(
                labelText: 'كلمة البحث',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('نطاق السعر', style: TextStyle(fontWeight: FontWeight.bold)),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000000,
              divisions: 10,
              labels: RangeLabels(
                '${_priceRange.start.round()} ر.ي',
                '${_priceRange.end.round()} ر.ي',
              ),
              onChanged: (v) => setState(() => _priceRange = v),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('اختر الفئة'),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              hint: const Text('اختر المدينة'),
              items: _cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCity = v),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('إعلانات بها صور فقط'),
              value: _withImages,
              onChanged: (v) => setState(() => _withImages = v ?? false),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'بحث',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري البحث...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
