import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class FruitsVegetablesScreen extends StatelessWidget {
  const FruitsVegetablesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'طماطم', 'icon': Icons.circle, 'color': Colors.red, 'count': '123'},
    {'name': 'بطاطس', 'icon': Icons.circle, 'color': Colors.brown, 'count': '98'},
    {'name': 'بصل', 'icon': Icons.circle, 'color': Colors.purple, 'count': '87'},
    {'name': 'موز', 'icon': Icons.eco, 'color': Colors.yellow, 'count': '76'},
    {'name': 'تفاح', 'icon': Icons.circle, 'color': Colors.red, 'count': '65'},
    {'name': 'برتقال', 'icon': Icons.circle, 'color': Colors.orange, 'count': '54'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الخضروات والفواكه'),
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
                  Text('${cat['count']} كجم', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
