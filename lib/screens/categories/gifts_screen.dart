import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class GiftsScreen extends StatelessWidget {
  const GiftsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'هدايا رجالية', 'icon': Icons.card_giftcard, 'color': Colors.blue, 'count': '234'},
    {'name': 'هدايا نسائية', 'icon': Icons.card_giftcard, 'color': Colors.pink, 'count': '345'},
    {'name': 'هدايا أطفال', 'icon': Icons.card_giftcard, 'color': Colors.green, 'count': '156'},
    {'name': 'بوكسات هدايا', 'icon': Icons.inventory, 'color': Colors.purple, 'count': '89'},
    {'name': 'ورود', 'icon': Icons.local_florist, 'color': Colors.red, 'count': '123'},
    {'name': 'شوكولاتة', 'icon': Icons.cake, 'color': Colors.brown, 'count': '98'},
    {'name': 'بطاقات معايدة', 'icon': Icons.email, 'color': Colors.orange, 'count': '45'},
    {'name': 'هدايا زفاف', 'icon': Icons.favorite, 'color': Colors.pink, 'count': '67'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الهدايا'),
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
                  Text('${cat['count']} هدية', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
