import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'أرز', 'icon': Icons.grass, 'color': Colors.brown, 'count': '456'},
    {'name': 'زيت', 'icon': Icons.opacity, 'color': Colors.yellow, 'count': '345'},
    {'name': 'سكر', 'icon': Icons.cake, 'color': Colors.white, 'count': '234'},
    {'name': 'طحين', 'icon': Icons.grain, 'color': Colors.grey, 'count': '189'},
    {'name': 'معكرونة', 'icon': Icons.spa, 'color': Colors.orange, 'count': '156'},
    {'name': 'بقوليات', 'icon': Icons.eco, 'color': Colors.green, 'count': '123'},
    {'name': 'بهارات', 'icon': Icons.grass, 'color': Colors.red, 'count': '98'},
    {'name': 'صلصات', 'icon': Icons.water_drop, 'color': Colors.red, 'count': '87'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المواد الغذائية'),
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
