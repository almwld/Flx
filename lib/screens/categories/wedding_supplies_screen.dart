import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class WeddingSuppliesScreen extends StatelessWidget {
  const WeddingSuppliesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'فساتين أعراس', 'icon': Icons.favorite, 'color': Colors.white, 'count': '234'},
    {'name': 'بدل عريس', 'icon': Icons.man, 'color': Colors.black, 'count': '156'},
    {'name': 'ذهب ومجوهرات', 'icon': Icons.diamond, 'color': Colors.amber, 'count': '89'},
    {'name': 'ديكور أعراس', 'icon': Icons.category, 'color': Colors.pink, 'count': '123'},
    {'name': 'ورود', 'icon': Icons.local_florist, 'color': Colors.red, 'count': '98'},
    {'name': 'كوشة', 'icon': Icons.chair, 'color': Colors.purple, 'count': '67'},
    {'name': 'سيارات فاخرة', 'icon': Icons.directions_car, 'color': Colors.amber, 'count': '45'},
    {'name': 'تصوير', 'icon': Icons.camera_alt, 'color': Colors.blue, 'count': '78'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'تجهيزات الأعراس'),
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
                  Text('${cat['count']} خدمة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
