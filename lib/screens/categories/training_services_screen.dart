import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class TrainingServicesScreen extends StatelessWidget {
  const TrainingServicesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'دورات لغة', 'icon': Icons.language, 'color': Colors.blue, 'count': '123'},
    {'name': 'دورات برمجة', 'icon': Icons.computer, 'color': Colors.green, 'count': '89'},
    {'name': 'تدريب مهني', 'icon': Icons.build, 'color': Colors.orange, 'count': '67'},
    {'name': 'تحفيظ قرآن', 'icon': Icons.mosque, 'color': Colors.green, 'count': '45'},
    {'name': 'دورات إدارية', 'icon': Icons.business, 'color': Colors.purple, 'count': '34'},
    {'name': 'تطوير ذاتي', 'icon': Icons.self_improvement, 'color': Colors.teal, 'count': '56'},
    {'name': 'دورات أونلاين', 'icon': Icons.laptop, 'color': Colors.red, 'count': '78'},
    {'name': 'شهادات مهنية', 'icon': Icons.card_membership, 'color': Colors.amber, 'count': '23'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'خدمات التعليم والتدريب'),
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
                  Text('${cat['count']} دورة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
