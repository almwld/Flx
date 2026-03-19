import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class ContractingServicesScreen extends StatelessWidget {
  const ContractingServicesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'بناء فلل', 'icon': Icons.villa, 'color': Colors.green, 'count': '89'},
    {'name': 'تشطيبات', 'icon': Icons.brush, 'color': Colors.orange, 'count': '156'},
    {'name': 'هدم وإزالة', 'icon': Icons.do_not_disturb, 'color': Colors.red, 'count': '45'},
    {'name': 'حفريات', 'icon': Icons.agriculture, 'color': Colors.brown, 'count': '67'},
    {'name': 'تسليك مجاري', 'icon': Icons.plumbing, 'color': Colors.grey, 'count': '34'},
    {'name': 'عزل مائي', 'icon': Icons.water, 'color': Colors.blue, 'count': '56'},
    {'name': 'واجهات زجاج', 'icon': Icons.window, 'color': Colors.cyan, 'count': '23'},
    {'name': 'دهانات', 'icon': Icons.brush, 'color': Colors.purple, 'count': '78'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'خدمات المقاولات'),
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
                  Text('${cat['count']} شركة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
