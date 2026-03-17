import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _mainCategories = const [
    // الإلكترونيات (7)
    {'name': 'هواتف ذكية', 'icon': Icons.phone_android, 'color': Colors.blue, 'count': '1,234'},
    {'name': 'لابتوب وكمبيوتر', 'icon': Icons.laptop, 'color': Colors.indigo, 'count': '892'},
    {'name': 'تابلت', 'icon': Icons.tablet, 'color': Colors.cyan, 'count': '456'},
    {'name': 'ساعات ذكية', 'icon': Icons.watch, 'color': Colors.teal, 'count': '789'},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': Colors.purple, 'count': '567'},
    {'name': 'سماعات', 'icon': Icons.headphones, 'color': Colors.deepPurple, 'count': '901'},
    {'name': 'اكسسوارات', 'icon': Icons.usb, 'color': Colors.pink, 'count': '1,112'},
    
    // السيارات (8)
    {'name': 'سيارات للبيع', 'icon': Icons.directions_car, 'color': Colors.red, 'count': '3,456'},
    {'name': 'سيارات للإيجار', 'icon': Icons.car_rental, 'color': Colors.orange, 'count': '789'},
    {'name': 'قطع غيار', 'icon': Icons.build, 'color': Colors.brown, 'count': '2,345'},
    {'name': 'إكسسوارات سيارات', 'icon': Icons.tire_repair, 'color': Colors.grey, 'count': '678'},
    {'name': 'دراجات نارية', 'icon': Icons.motorcycle, 'color': Colors.deepOrange, 'count': '234'},
    {'name': 'قوارب', 'icon': Icons.sailing, 'color': Colors.lightBlue, 'count': '123'},
    {'name': 'شاحنات', 'icon': Icons.local_shipping, 'color': Colors.amber, 'count': '345'},
    {'name': 'معدات ثقيلة', 'icon': Icons.construction, 'color': Colors.yellow, 'count': '567'},
    
    // العقارات (6)
    {'name': 'شقق للبيع', 'icon': Icons.apartment, 'color': Colors.green, 'count': '2,789'},
    {'name': 'شقق للإيجار', 'icon': Icons.home, 'color': Colors.lightGreen, 'count': '1,567'},
    {'name': 'فلل وقصور', 'icon': Icons.villa, 'color': Colors.lime, 'count': '890'},
    {'name': 'أراضي', 'icon': Icons.terrain, 'color': Colors.green, 'count': '1,234'},
    {'name': 'محلات تجارية', 'icon': Icons.store, 'color': Colors.teal, 'count': '456'},
    {'name': 'مكاتب', 'icon': Icons.business, 'color': Colors.blueGrey, 'count': '678'},
    
    // الأثاث (5)
    {'name': 'غرف نوم', 'icon': Icons.bed, 'color': Colors.brown, 'count': '1,456'},
    {'name': 'غرف معيشة', 'icon': Icons.chair, 'color': Colors.amber, 'count': '890'},
    {'name': 'مطابخ', 'icon': Icons.kitchen, 'color': Colors.deepOrange, 'count': '567'},
    {'name': 'مكاتب', 'icon': Icons.desk, 'color': Colors.indigo, 'count': '345'},
    {'name': 'إضاءة', 'icon': Icons.light, 'color': Colors.yellow, 'count': '234'},
    
    // الملابس (6)
    {'name': 'رجالي', 'icon': Icons.man, 'color': Colors.blue, 'count': '2,345'},
    {'name': 'نسائي', 'icon': Icons.woman, 'color': Colors.pink, 'count': '3,456'},
    {'name': 'أطفال', 'icon': Icons.child_care, 'color': Colors.teal, 'count': '1,234'},
    {'name': 'أحذية', 'icon': Icons.shopping_bag, 'color': Colors.brown, 'count': '890'},
    {'name': 'إكسسوارات', 'icon': Icons.watch, 'color': Colors.purple, 'count': '567'},
    {'name': 'ساعات', 'icon': Icons.watch, 'color': Colors.deepPurple, 'count': '678'},
    
    // المطاعم والأكل (5)
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.red, 'count': '1,234'},
    {'name': 'مقاهي', 'icon': Icons.local_cafe, 'color': Colors.brown, 'count': '890'},
    {'name': 'حلويات', 'icon': Icons.cake, 'color': Colors.pink, 'count': '567'},
    {'name': 'مخابز', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'count': '345'},
    {'name': 'وجبات سريعة', 'icon': Icons.fastfood, 'color': Colors.deepOrange, 'count': '456'},
    
    // الخدمات (7)
    {'name': 'صيانة', 'icon': Icons.build, 'color': Colors.grey, 'count': '1,234'},
    {'name': 'تنظيف', 'icon': Icons.cleaning_services, 'color': Colors.cyan, 'count': '678'},
    {'name': 'تصليح', 'icon': Icons.plumbing, 'color': Colors.brown, 'count': '456'},
    {'name': 'نقل', 'icon': Icons.local_shipping, 'color': Colors.amber, 'count': '567'},
    {'name': 'تعليم', 'icon': Icons.school, 'color': Colors.green, 'count': '789'},
    {'name': 'صحة', 'icon': Icons.health_and_safety, 'color': Colors.red, 'count': '890'},
    {'name': 'جمال', 'icon': Icons.face, 'color': Colors.pink, 'count': '678'},
    
    // الحيوانات (4)
    {'name': 'كلاب', 'icon': Icons.pets, 'color': Colors.brown, 'count': '345'},
    {'name': 'قطط', 'icon': Icons.pets, 'color': Colors.orange, 'count': '456'},
    {'name': 'طيور', 'icon': Icons.flutter_dash, 'color': Colors.blue, 'count': '234'},
    {'name': 'أسماك', 'icon': Icons.set_meal, 'color': Colors.teal, 'count': '123'},
    
    // الرياضة (4)
    {'name': 'أدوات رياضية', 'icon': Icons.sports, 'color': Colors.green, 'count': '678'},
    {'name': 'ملابس رياضية', 'icon': Icons.sports_handball, 'color': Colors.orange, 'count': '456'},
    {'name': 'أندية', 'icon': Icons.sports_soccer, 'color': Colors.blue, 'count': '234'},
    {'name': 'معدات', 'icon': Icons.fitness_center, 'color': Colors.red, 'count': '345'},
    
    // الكتب والقرطاسية (3)
    {'name': 'كتب', 'icon': Icons.book, 'color': Colors.brown, 'count': '567'},
    {'name': 'قرطاسية', 'icon': Icons.create, 'color': Colors.purple, 'count': '345'},
    {'name': 'مستلزمات مدرسية', 'icon': Icons.school, 'color': Colors.green, 'count': '456'},
    
    // الألعاب (4)
    {'name': 'ألعاب إلكترونية', 'icon': Icons.videogame_asset, 'color': Colors.red, 'count': '890'},
    {'name': 'ألعاب أطفال', 'icon': Icons.toys, 'color': Colors.pink, 'count': '678'},
    {'name': 'دمى', 'icon': Icons.emoji_people, 'color': Colors.purple, 'count': '234'},
    {'name': 'ليغو', 'icon': Icons.extension, 'color': Colors.amber, 'count': '123'},
    
    // الوظائف (2)
    {'name': 'وظائف', 'icon': Icons.work, 'color': Colors.blue, 'count': '456'},
    {'name': 'توظيف', 'icon': Icons.person_search, 'color': Colors.green, 'count': '234'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الأقسام'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _mainCategories.length,
        itemBuilder: (context, index) {
          final category = _mainCategories[index];
          return GestureDetector(
            onTap: () {
              // فتح صفحة الفئة
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (category['color'] as Color).withOpacity(0.3),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['count'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
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
