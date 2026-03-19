import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AllAdsScreenPart2 extends StatelessWidget {
  const AllAdsScreenPart2({super.key});

  final List<Map<String, dynamic>> _categories = const [
    // الصحة والجمال (8)
    {'name': 'مستحضرات تجميل', 'icon': Icons.face, 'color': Colors.pink},
    {'name': 'عناية بالبشرة', 'icon': Icons.spa, 'color': Colors.purple},
    {'name': 'عطور', 'icon': Icons.emoji_emotions, 'color': Colors.amber},
    {'name': 'مكياج', 'icon': Icons.brush, 'color': Colors.red},
    {'name': 'أدوات حلاقة', 'icon': Icons.cut, 'color': Colors.blue},
    {'name': 'عناية بالشعر', 'icon': Icons.content_cut, 'color': Colors.teal},
    {'name': 'سبا', 'icon': Icons.hot_tub, 'color': Colors.cyan},
    {'name': 'صيدليات', 'icon': Icons.local_pharmacy, 'color': Colors.green},

    // الأجهزة المنزلية (7)
    {'name': 'ثلاجات', 'icon': Icons.kitchen, 'color': Colors.cyan},
    {'name': 'غسالات', 'icon': Icons.local_laundry_service, 'color': Colors.blue},
    {'name': 'مكيفات', 'icon': Icons.ac_unit, 'color': Colors.lightBlue},
    {'name': 'أفران', 'icon': Icons.kitchen, 'color': Colors.orange},
    {'name': 'مكانس', 'icon': Icons.cleaning_services, 'color': Colors.purple},
    {'name': 'مراوح', 'icon': Icons.toys, 'color': Colors.green},
    {'name': 'سخانات', 'icon': Icons.water, 'color': Colors.red},

    // المطبخ والطعام (6)
    {'name': 'أواني', 'icon': Icons.kitchen, 'color': Colors.brown},
    {'name': 'أجهزة مطبخ', 'icon': Icons.coffee_maker, 'color': Colors.amber},
    {'name': 'بهارات', 'icon': Icons.grass, 'color': Colors.green},
    {'name': 'تمور', 'icon': Icons.date_range, 'color': Colors.brown},
    {'name': 'عسل', 'icon': Icons.water_drop, 'color': Colors.amber},
    {'name': 'قهوة', 'icon': Icons.coffee, 'color': Colors.brown},

    // الحرف والتحف (5)
    {'name': 'جنابي', 'icon': Icons.agriculture, 'color': Colors.brown},
    {'name': 'سجاد', 'icon': Icons.carpenter, 'color': Colors.red},
    {'name': 'فضيات', 'icon': Icons.diamond, 'color': Colors.grey},
    {'name': 'نحاسيات', 'icon': Icons.kitchen, 'color': Colors.amber},
    {'name': 'تحف', 'icon': Icons.history, 'color': Colors.brown},

    // مواد البناء (6)
    {'name': 'حديد', 'icon': Icons.construction, 'color': Colors.grey},
    {'name': 'أسمنт', 'icon': Icons.inventory, 'color': Colors.brown},
    {'name': 'رمل', 'icon': Icons.landscape, 'color': Colors.yellow},
    {'name': 'سيراميك', 'icon': Icons.grid_on, 'color': Colors.blue},
    {'name': 'دهانات', 'icon': Icons.brush, 'color': Colors.purple},
    {'name': 'أدوات صحية', 'icon': Icons.bathtub, 'color': Colors.cyan},

    // الزراعة (5)
    {'name': 'بذور', 'icon': Icons.grass, 'color': Colors.green},
    {'name': 'شتلات', 'icon': Icons.eco, 'color': Colors.lightGreen},
    {'name': 'أسمدة', 'icon': Icons.agriculture, 'color': Colors.brown},
    {'name': 'مبيدات', 'icon': Icons.science, 'color': Colors.red},
    {'name': 'أدوات زراعية', 'icon': Icons.agriculture, 'color': Colors.orange},

    // التعليم (4)
    {'name': 'دورات', 'icon': Icons.school, 'color': Colors.blue},
    {'name': 'كتب تعليمية', 'icon': Icons.menu_book, 'color': Colors.green},
    {'name': 'مستلزمات', 'icon': Icons.backpack, 'color': Colors.orange},
    {'name': 'معاهد', 'icon': Icons.location_city, 'color': Colors.purple},

    // السفر (4)
    {'name': 'فنادق', 'icon': Icons.hotel, 'color': Colors.blue},
    {'name': 'رحلات', 'icon': Icons.tour, 'color': Colors.green},
    {'name': 'تذاكر', 'icon': Icons.flight, 'color': Colors.orange},
    {'name': 'تأجير سيارات', 'icon': Icons.car_rental, 'color': Colors.red},

    // المزادات (3)
    {'name': 'مزادات سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'مزادات عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'مزادات تحف', 'icon': Icons.history, 'color': Colors.brown},

    // التبرعات (3)
    {'name': 'تبرعات مالية', 'icon': Icons.volunteer_activism, 'color': Colors.green},
    {'name': 'تبرعات عينية', 'icon': Icons.card_giftcard, 'color': Colors.orange},
    {'name': 'حملات خيرية', 'icon': Icons.favorite, 'color': Colors.red},

    // الكماليات (4)
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': Colors.red},
    {'name': 'ساعات فاخرة', 'icon': Icons.watch, 'color': Colors.amber},
    {'name': 'نظارات', 'icon': Icons.visibility, 'color': Colors.blue},
    {'name': 'مجوهرات', 'icon': Icons.diamond, 'color': Colors.purple},

    // المعدات الثقيلة (4)
    {'name': 'حفارات', 'icon': Icons.construction, 'color': Colors.yellow},
    {'name': 'رافعات', 'icon': Icons.construction, 'color': Colors.orange},
    {'name': 'بلدوزرات', 'icon': Icons.do_not_disturb, 'color': Colors.red},
    {'name': 'شيولات', 'icon': Icons.local_shipping, 'color': Colors.blue},

    // البرمجيات (3)
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.blue},
    {'name': 'برامج', 'icon': Icons.computer, 'color': Colors.green},
    {'name': 'ألعاب', 'icon': Icons.videogame_asset, 'color': Colors.purple},

    // الأمن (3)
    {'name': 'كاميرات', 'icon': Icons.videocam, 'color': Colors.blue},
    {'name': 'إنذار', 'icon': Icons.warning, 'color': Colors.red},
    {'name': 'أقفال', 'icon': Icons.lock, 'color': Colors.grey},

    // الموسيقى (3)
    {'name': 'آلات موسيقية', 'icon': Icons.music_note, 'color': Colors.purple},
    {'name': 'سماعات', 'icon': Icons.speaker, 'color': Colors.blue},
    {'name': 'مكبرات', 'icon': Icons.headphones, 'color': Colors.red},

    // العملات (2)
    {'name': 'عملات قديمة', 'icon': Icons.monetization_on, 'color': Colors.amber},
    {'name': 'طوابع', 'icon': Icons.markunread_mailbox, 'color': Colors.green},

    // السينما (2)
    {'name': 'أفلام', 'icon': Icons.movie, 'color': Colors.red},
    {'name': 'مسلسلات', 'icon': Icons.tv, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الأقسام - الجزء الثاني'),
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
