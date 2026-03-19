import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class TraditionalFoodScreen extends StatelessWidget {
  const TraditionalFoodScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'مندي', 'icon': Icons.restaurant, 'color': Colors.brown, 'count': '234'},
    {'name': 'برياني', 'icon': Icons.restaurant, 'color': Colors.orange, 'count': '189'},
    {'name': 'زربيان', 'icon': Icons.restaurant, 'color': Colors.red, 'count': '156'},
    {'name': 'مظبي', 'icon': Icons.restaurant, 'color': Colors.amber, 'count': '123'},
    {'name': 'حنيذ', 'icon': Icons.restaurant, 'color': Colors.brown, 'count': '98'},
    {'name': 'مفطح', 'icon': Icons.restaurant, 'color': Colors.orange, 'count': '87'},
    {'name': 'عصيدة', 'icon': Icons.breakfast_dining, 'color': Colors.yellow, 'count': '76'},
    {'name': 'فتة', 'icon': Icons.breakfast_dining, 'color': Colors.white, 'count': '65'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المأكولات الشعبية'),
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
                  Text('${cat['count']} وجبة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
