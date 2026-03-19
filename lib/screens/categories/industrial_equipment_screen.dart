import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class IndustrialEquipmentScreen extends StatelessWidget {
  const IndustrialEquipmentScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'مكائن صناعية', 'icon': Icons.precision_manufacturing, 'color': Colors.grey, 'count': '156'},
    {'name': 'مولدات كهرباء', 'icon': Icons.electrical_services, 'color': Colors.yellow, 'count': '89'},
    {'name': 'ضواغط هواء', 'icon': Icons.compress, 'color': Colors.blue, 'count': '67'},
    {'name': 'مضخات', 'icon': Icons.water_drop, 'color': Colors.cyan, 'count': '45'},
    {'name': 'سيور ناقلة', 'icon': Icons.conveyor_belt, 'color': Colors.orange, 'count': '34'},
    {'name': 'أفران صناعية', 'icon': Icons.kitchen, 'color': Colors.red, 'count': '23'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المعدات الصناعية'),
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
                  Text('${cat['count']} معدة', style: const TextStyle(fontFamily: 'Changa', fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
