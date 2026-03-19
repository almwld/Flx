import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class DeliveryServicesScreen extends StatelessWidget {
  const DeliveryServicesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'نقل عفش', 'icon': Icons.local_shipping, 'color': Colors.orange, 'count': '234'},
    {'name': 'توصيل طلبات', 'icon': Icons.delivery_dining, 'color': Colors.red, 'count': '345'},
    {'name': 'شحن بري', 'icon': Icons.directions_bus, 'color': Colors.green, 'count': '156'},
    {'name': 'شحن بحري', 'icon': Icons.directions_boat, 'color': Colors.blue, 'count': '89'},
    {'name': 'شحن جوي', 'icon': Icons.flight, 'color': Colors.purple, 'count': '67'},
    {'name': 'تغليف', 'icon': Icons.inventory, 'color': Colors.brown, 'count': '45'},
    {'name': 'نقل مدارس', 'icon': Icons.school, 'color': Colors.yellow, 'count': '34'},
    {'name': 'نقل موظفين', 'icon': Icons.business, 'color': Colors.grey, 'count': '23'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'خدمات النقل والتوصيل'),
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
