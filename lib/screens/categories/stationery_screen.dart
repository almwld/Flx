import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class StationeryScreen extends StatelessWidget {
  const StationeryScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'أقلام', 'icon': Icons.edit, 'color': Colors.blue, 'count': '456'},
    {'name': 'دفاتر', 'icon': Icons.note, 'color': Colors.green, 'count': '345'},
    {'name': 'ألوان', 'icon': Icons.color_lens, 'color': Colors.red, 'count': '234'},
    {'name': 'كراسات', 'icon': Icons.book, 'color': Colors.orange, 'count': '123'},
    {'name': 'أدوات هندسية', 'icon': Icons.straighten, 'color': Colors.purple, 'count': '89'},
    {'name': 'مجلدات', 'icon': Icons.folder, 'color': Colors.brown, 'count': '67'},
    {'name': 'طابعات', 'icon': Icons.print, 'color': Colors.teal, 'count': '45'},
    {'name': 'أحبار', 'icon': Icons.opacity, 'color': Colors.amber, 'count': '34'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'القرطاسية'),
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
