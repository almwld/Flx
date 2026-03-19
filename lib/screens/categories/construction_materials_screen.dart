import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class ConstructionMaterialsScreen extends StatelessWidget {
  const ConstructionMaterialsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'حديد', 'icon': Icons.construction, 'color': Colors.grey, 'count': '456'},
    {'name': 'أسمنت', 'icon': Icons.inventory, 'color': Colors.brown, 'count': '345'},
    {'name': 'رمل وبحص', 'icon': Icons.landscape, 'color': Colors.yellow, 'count': '234'},
    {'name': 'سيراميك', 'icon': Icons.grid_on, 'color': Colors.blue, 'count': '123'},
    {'name': 'دهانات', 'icon': Icons.brush, 'color': Colors.purple, 'count': '89'},
    {'name': 'أدوات صحية', 'icon': Icons.bathtub, 'color': Colors.cyan, 'count': '67'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'مواد البناء'),
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
