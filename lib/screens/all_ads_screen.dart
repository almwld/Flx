import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});

  final List<Map<String, dynamic>> _allCategories = const [
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.brown},
    {'name': 'ملابس', 'icon': Icons.checkroom, 'color': Colors.purple},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.orange},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Colors.teal},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': Colors.pink},
    {'name': 'رياضة', 'icon': Icons.sports, 'color': Colors.green},
    {'name': 'كتب', 'icon': Icons.book, 'color': Colors.brown},
    {'name': 'صحة', 'icon': Icons.health_and_safety, 'color': Colors.red},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.blue},
    {'name': 'جمال', 'icon': Icons.face, 'color': Colors.pink},
    {'name': 'مطبخ', 'icon': Icons.kitchen, 'color': Colors.orange},
    {'name': 'أجهزة', 'icon': Icons.kitchen, 'color': Colors.cyan},
    {'name': 'مجوهرات', 'icon': Icons.diamond, 'color': Colors.amber},
    {'name': 'ساعات', 'icon': Icons.watch, 'color': Colors.grey},
    {'name': 'حقائب', 'icon': Icons.bag, 'color': Colors.brown},
    {'name': 'أحذية', 'icon': Icons.shoes, 'color': Colors.red},
    {'name': 'عطور', 'icon': Icons.emoji_emotions, 'color': Colors.purple},
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': Colors.red},
    {'name': 'زهور', 'icon': Icons.local_florist, 'color': Colors.pink},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': Colors.grey},
    {'name': 'سفر', 'icon': Icons.flight, 'color': Colors.blue},
    {'name': 'تعليم', 'icon': Icons.school, 'color': Colors.green},
    {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.orange},
    {'name': 'معدات', 'icon': Icons.construction, 'color': Colors.yellow},
    {'name': 'حدادة', 'icon': Icons.construction, 'color': Colors.grey},
    {'name': 'نجارة', 'icon': Icons.handyman, 'color': Colors.brown},
    {'name': 'سباكة', 'icon': Icons.plumbing, 'color': Colors.blue},
    {'name': 'كهرباء', 'icon': Icons.electrical_services, 'color': Colors.yellow},
    {'name': 'دهانات', 'icon': Icons.brush, 'color': Colors.purple},
    {'name': 'سيراميك', 'icon': Icons.grid_on, 'color': Colors.orange},
    {'name': 'رخام', 'icon': Icons.landscape, 'color': Colors.grey},
    {'name': 'زجاج', 'icon': Icons.window, 'color': Colors.cyan},
    {'name': 'ألمنيوم', 'icon': Icons.fence, 'color': Colors.grey},
    {'name': 'خشب', 'icon': Icons.forest, 'color': Colors.brown},
    {'name': 'حديد', 'icon': Icons.construction, 'color': Colors.grey},
    {'name': 'أسمنت', 'icon': Icons.inventory, 'color': Colors.grey},
    {'name': 'رمل', 'icon': Icons.landscape, 'color': Colors.yellow},
    {'name': 'بحص', 'icon': Icons.grain, 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الأقسام'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _allCategories.length,
        itemBuilder: (context, index) {
          final cat = _allCategories[index];
          return GestureDetector(
            onTap: () {
              // فتح صفحة القسم
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: cat['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
