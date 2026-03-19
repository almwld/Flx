import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'كلاب', 'icon': Icons.pets, 'color': Colors.brown, 'count': '234'},
    {'name': 'قطط', 'icon': Icons.pets, 'color': Colors.orange, 'count': '345'},
    {'name': 'طيور', 'icon': Icons.flutter_dash, 'color': Colors.blue, 'count': '123'},
    {'name': 'أسماك', 'icon': Icons.set_meal, 'color': Colors.teal, 'count': '89'},
    {'name': 'أرانب', 'icon': Icons.pets, 'color': Colors.pink, 'count': '45'},
    {'name': 'أعلاف', 'icon': Icons.grass, 'color': Colors.green, 'count': '156'},
    {'name': 'مستلزمات', 'icon': Icons.shopping_bag, 'color': Colors.purple, 'count': '98'},
    {'name': 'أدوية بيطرية', 'icon': Icons.local_pharmacy, 'color': Colors.red, 'count': '67'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الحيوانات الأليفة'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: (cat['color'] as Color).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'] as IconData, color: cat['color']),
                  ),
                  const SizedBox(height: 8),
                  Text(cat['name'], style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${cat['count']} منتج', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
