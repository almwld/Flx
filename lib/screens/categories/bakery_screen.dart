import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class BakeryScreen extends StatelessWidget {
  const BakeryScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'خبز عربي', 'icon': Icons.bakery_dining, 'color': Colors.brown, 'count': '234'},
    {'name': 'خبز فرنسي', 'icon': Icons.bakery_dining, 'color': Colors.amber, 'count': '156'},
    {'name': 'كرواسون', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'count': '123'},
    {'name': 'كعك', 'icon': Icons.cake, 'color': Colors.pink, 'count': '98'},
    {'name': 'بسكويت', 'icon': Icons.cookie, 'color': Colors.brown, 'count': '87'},
    {'name': 'حلويات شرقية', 'icon': Icons.cake, 'color': Colors.purple, 'count': '76'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المخبوزات والمعجنات'),
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
