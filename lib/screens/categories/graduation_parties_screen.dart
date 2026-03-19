import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class GraduationPartiesScreen extends StatelessWidget {
  const GraduationPartiesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'هدايا تخرج', 'icon': Icons.card_giftcard, 'color': Colors.blue, 'count': '234'},
    {'name': 'دروع تذكارية', 'icon': Icons.emoji_events, 'color': Colors.amber, 'count': '156'},
    {'name': 'بوكسات ورد', 'icon': Icons.local_florist, 'color': Colors.red, 'count': '123'},
    {'name': 'توزيعات', 'icon': Icons.card_giftcard, 'color': Colors.pink, 'count': '98'},
    {'name': 'بالونات', 'icon': Icons.circle, 'color': Colors.purple, 'count': '87'},
    {'name': 'ديكور حفلات', 'icon': Icons.category, 'color': Colors.orange, 'count': '76'},
    {'name': 'تصوير', 'icon': Icons.camera_alt, 'color': Colors.blue, 'count': '65'},
    {'name': 'كوشة تصوير', 'icon': Icons.photo_camera, 'color': Colors.pink, 'count': '54'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'حفلات وتخرج'),
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
