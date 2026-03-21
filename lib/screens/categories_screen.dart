import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'إلكترونيات', 'icon': Icons.devices},
    {'name': 'سيارات', 'icon': Icons.directions_car},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'أثاث', 'icon': Icons.chair},
    {'name': 'ملابس', 'icon': Icons.checkroom},
    {'name': 'أطعمة', 'icon': Icons.restaurant},
    {'name': 'رياضة', 'icon': Icons.sports},
    {'name': 'كتب', 'icon': Icons.book},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الفئات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2),
        itemCount: categories.length,
        itemBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/all_ads'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(categories[index]['icon'], size: 48, color: AppTheme.goldColor),
                const SizedBox(height: 12),
                Text(categories[index]['name'], style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
