import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class LuxuryFurnitureScreen extends StatelessWidget {
  const LuxuryFurnitureScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'غرف نوم فاخرة', 'icon': Icons.bed, 'color': Colors.brown, 'count': '89'},
    {'name': 'مجالس عربية', 'icon': Icons.chair, 'color': Colors.amber, 'count': '67'},
    {'name': 'صالات استقبال', 'icon': Icons.weekend, 'color': Colors.purple, 'count': '45'},
    {'name': 'طاولات طعام', 'icon': Icons.dining, 'color': Colors.green, 'count': '34'},
    {'name': 'مكاتب فاخرة', 'icon': Icons.desk, 'color': Colors.blue, 'count': '23'},
    {'name': 'إضاءة فاخرة', 'icon': Icons.light, 'color': Colors.yellow, 'count': '12'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأثاث الفاخر'),
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
                  Text('${cat['count']} قطعة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
