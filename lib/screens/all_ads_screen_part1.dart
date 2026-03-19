import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AllAdsScreenPart1 extends StatelessWidget {
  const AllAdsScreenPart1({super.key});

  final List<Map<String, dynamic>> _categories = const [
    // الإلكترونيات (7)
    {'name': 'هواتف ذكية', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'لابتوب', 'icon': Icons.laptop, 'color': Colors.indigo},
    {'name': 'تابلت', 'icon': Icons.tablet, 'color': Colors.cyan},
    {'name': 'ساعات ذكية', 'icon': Icons.watch, 'color': Colors.teal},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': Colors.purple},
    {'name': 'سماعات', 'icon': Icons.headphones, 'color': Colors.deepPurple},
    {'name': 'اكسسوارات', 'icon': Icons.usb, 'color': Colors.pink},

    // السيارات (8)
    {'name': 'سيارات للبيع', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'سيارات للإيجار', 'icon': Icons.car_rental, 'color': Colors.orange},
    {'name': 'قطع غيار', 'icon': Icons.build, 'color': Colors.brown},
    {'name': 'اكسسوارات سيارات', 'icon': Icons.tire_repair, 'color': Colors.grey},
    {'name': 'دراجات نارية', 'icon': Icons.motorcycle, 'color': Colors.deepOrange},
    {'name': 'قوارب', 'icon': Icons.sailing, 'color': Colors.lightBlue},
    {'name': 'شاحنات', 'icon': Icons.local_shipping, 'color': Colors.amber},
    {'name': 'معدات ثقيلة', 'icon': Icons.construction, 'color': Colors.yellow},

    // العقارات (6)
    {'name': 'شقق للبيع', 'icon': Icons.apartment, 'color': Colors.green},
    {'name': 'شقق للإيجار', 'icon': Icons.home, 'color': Colors.lightGreen},
    {'name': 'فلل', 'icon': Icons.villa, 'color': Colors.lime},
    {'name': 'أراضي', 'icon': Icons.terrain, 'color': Colors.green},
    {'name': 'محلات', 'icon': Icons.store, 'color': Colors.teal},
    {'name': 'مكاتب', 'icon': Icons.business, 'color': Colors.blueGrey},

    // الأثاث (5)
    {'name': 'غرف نوم', 'icon': Icons.bed, 'color': Colors.brown},
    {'name': 'غرف معيشة', 'icon': Icons.chair, 'color': Colors.amber},
    {'name': 'مطابخ', 'icon': Icons.kitchen, 'color': Colors.deepOrange},
    {'name': 'مكاتب', 'icon': Icons.desk, 'color': Colors.indigo},
    {'name': 'إضاءة', 'icon': Icons.light, 'color': Colors.yellow},

    // الملابس (6)
    {'name': 'رجالي', 'icon': Icons.man, 'color': Colors.blue},
    {'name': 'نسائي', 'icon': Icons.woman, 'color': Colors.pink},
    {'name': 'أطفال', 'icon': Icons.child_care, 'color': Colors.teal},
    {'name': 'أحذية', 'icon': Icons.shopping_bag, 'color': Colors.brown},
    {'name': 'اكسسوارات', 'icon': Icons.watch, 'color': Colors.purple},
    {'name': 'ساعات', 'icon': Icons.watch, 'color': Colors.deepPurple},

    // المطاعم والأكل (5)
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.red},
    {'name': 'مقاهي', 'icon': Icons.local_cafe, 'color': Colors.brown},
    {'name': 'حلويات', 'icon': Icons.cake, 'color': Colors.pink},
    {'name': 'مخابز', 'icon': Icons.bakery_dining, 'color': Colors.orange},
    {'name': 'وجبات سريعة', 'icon': Icons.fastfood, 'color': Colors.deepOrange},

    // الخدمات (7)
    {'name': 'صيانة', 'icon': Icons.build, 'color': Colors.grey},
    {'name': 'تنظيف', 'icon': Icons.cleaning_services, 'color': Colors.cyan},
    {'name': 'تصليح', 'icon': Icons.plumbing, 'color': Colors.brown},
    {'name': 'نقل', 'icon': Icons.local_shipping, 'color': Colors.amber},
    {'name': 'تعليم', 'icon': Icons.school, 'color': Colors.green},
    {'name': 'صحة', 'icon': Icons.health_and_safety, 'color': Colors.red},
    {'name': 'جمال', 'icon': Icons.face, 'color': Colors.pink},

    // الحيوانات (4)
    {'name': 'كلاب', 'icon': Icons.pets, 'color': Colors.brown},
    {'name': 'قطط', 'icon': Icons.pets, 'color': Colors.orange},
    {'name': 'طيور', 'icon': Icons.flutter_dash, 'color': Colors.blue},
    {'name': 'أسماك', 'icon': Icons.set_meal, 'color': Colors.teal},

    // الرياضة (4)
    {'name': 'أدوات رياضية', 'icon': Icons.sports, 'color': Colors.green},
    {'name': 'ملابس رياضية', 'icon': Icons.sports_handball, 'color': Colors.orange},
    {'name': 'أندية', 'icon': Icons.sports_soccer, 'color': Colors.blue},
    {'name': 'معدات', 'icon': Icons.fitness_center, 'color': Colors.red},

    // الكتب والقرطاسية (3)
    {'name': 'كتب', 'icon': Icons.book, 'color': Colors.brown},
    {'name': 'قرطاسية', 'icon': Icons.create, 'color': Colors.purple},
    {'name': 'مستلزمات مدرسية', 'icon': Icons.school, 'color': Colors.green},

    // الألعاب (4)
    {'name': 'ألعاب إلكترونية', 'icon': Icons.videogame_asset, 'color': Colors.red},
    {'name': 'ألعاب أطفال', 'icon': Icons.toys, 'color': Colors.pink},
    {'name': 'دمى', 'icon': Icons.emoji_people, 'color': Colors.purple},
    {'name': 'ليغو', 'icon': Icons.extension, 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأقسام - الجزء الأول'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'] as IconData, color: cat['color'], size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(cat['name'], style: TextStyle(fontFamily: 'Changa', fontSize: 11), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
