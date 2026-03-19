import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class BabyKidsScreen extends StatelessWidget {
  const BabyKidsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'ملابس أطفال', 'icon': Icons.child_care, 'color': Colors.blue, 'count': '567'},
    {'name': 'حفاضات', 'icon': Icons.inventory, 'color': Colors.green, 'count': '234'},
    {'name': 'ألعاب أطفال', 'icon': Icons.toys, 'color': Colors.red, 'count': '345'},
    {'name': 'عربات أطفال', 'icon': Icons.airline_seat_recline_normal, 'color': Colors.orange, 'count': '89'},
    {'name': 'مقاعد سيارة', 'icon': Icons.car_rental, 'color': Colors.purple, 'count': '67'},
    {'name': 'مستلزمات رضاعة', 'icon': Icons.emoji_food_beverage, 'color': Colors.pink, 'count': '156'},
    {'name': 'أثاث أطفال', 'icon': Icons.bed, 'color': Colors.brown, 'count': '78'},
    {'name': 'هدايا مواليد', 'icon': Icons.card_giftcard, 'color': Colors.teal, 'count': '45'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'مستلزمات الأطفال'),
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
