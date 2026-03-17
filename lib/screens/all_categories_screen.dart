import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'categories/health_beauty_screen.dart';
import 'categories/home_appliances_screen.dart';
import 'categories/kitchen_food_screen.dart';
import 'categories/handicrafts_antiques_screen.dart';
import 'categories/construction_materials_screen.dart';
import 'categories/agriculture_screen.dart';
import 'categories/education_screen.dart';
import 'categories/travel_tourism_screen.dart';
import 'categories/auctions_category_screen.dart';
import 'categories/donations_screen.dart';
import 'categories/luxury_items_screen.dart';
import 'categories/heavy_equipment_screen.dart';
import 'categories/software_screen.dart';
import 'categories/security_safety_screen.dart';
import 'categories/aviation_screen.dart';
import 'categories/music_screen.dart';
import 'categories/currency_screen.dart';
import 'categories/cinema_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'الصحة والجمال', 'screen': HealthBeautyScreen, 'color': Colors.pink},
    {'name': 'الأجهزة المنزلية', 'screen': HomeAppliancesScreen, 'color': Colors.cyan},
    {'name': 'المطبخ والطعام', 'screen': KitchenFoodScreen, 'color': Colors.amber},
    {'name': 'الحرف والتحف', 'screen': HandicraftsAntiquesScreen, 'color': Colors.brown},
    {'name': 'مواد البناء', 'screen': ConstructionMaterialsScreen, 'color': Colors.grey},
    {'name': 'الزراعة', 'screen': AgricultureScreen, 'color': Colors.green},
    {'name': 'التعليم', 'screen': EducationScreen, 'color': Colors.blue},
    {'name': 'السفر والسياحة', 'screen': TravelTourismScreen, 'color': Colors.orange},
    {'name': 'المزادات', 'screen': AuctionsCategoryScreen, 'color': Colors.red},
    {'name': 'التبرعات', 'screen': DonationsScreen, 'color': Colors.teal},
    {'name': 'الكماليات', 'screen': LuxuryItemsScreen, 'color': Colors.purple},
    {'name': 'المعدات الثقيلة', 'screen': HeavyEquipmentScreen, 'color': Colors.yellow},
    {'name': 'البرمجيات', 'screen': SoftwareScreen, 'color': Colors.indigo},
    {'name': 'الأمن والسلامة', 'screen': SecuritySafetyScreen, 'color': Colors.grey},
    {'name': 'الطيران', 'screen': AviationScreen, 'color': Colors.lightBlue},
    {'name': 'الموسيقى', 'screen': MusicScreen, 'color': Colors.purple},
    {'name': 'العملات والطوابع', 'screen': CurrencyScreen, 'color': Colors.amber},
    {'name': 'السينما', 'screen': CinemaScreen, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الأقسام'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => cat['screen']()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.category, color: cat['color']),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      cat['name'],
                      style: const TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
    {'name': 'السيارات الفاخرة', 'screen': LuxuryCarsScreen, 'color': Colors.grey},
    {'name': 'العقارات التجارية', 'screen': CommercialRealestateScreen, 'color': Colors.blue},
    {'name': 'الإلكترونيات الاستهلاكية', 'screen': ConsumerElectronicsScreen, 'color': Colors.red},
    {'name': 'الأثاث الفاخر', 'screen': LuxuryFurnitureScreen, 'color': Colors.brown},
    {'name': 'المجوهرات والساعات', 'screen': JewelryWatchesScreen, 'color': Colors.amber},
    {'name': 'العطور والمكياج', 'screen': PerfumesMakeupScreen, 'color': Colors.pink},
    {'name': 'الأطعمة والمشروبات', 'screen': FoodBeveragesScreen, 'color': Colors.orange},
    {'name': 'مستلزمات الأطفال', 'screen': BabyKidsScreen, 'color': Colors.blue},
    {'name': 'الحيوانات الأليفة', 'screen': PetsScreen, 'color': Colors.brown},
    {'name': 'الهدايا', 'screen': GiftsScreen, 'color': Colors.red},
    {'name': 'الرياضة واللياقة', 'screen': SportsFitnessScreen, 'color': Colors.green},
    {'name': 'القرطاسية', 'screen': StationeryScreen, 'color': Colors.purple},
    {'name': 'المعدات الصناعية', 'screen': IndustrialEquipmentScreen, 'color': Colors.grey},
    {'name': 'الأدوات الكهربائية', 'screen': ElectricalToolsScreen, 'color': Colors.yellow},
    {'name': 'أدوات السباكة', 'screen': PlumbingToolsScreen, 'color': Colors.blue},
    {'name': 'أدوات النجارة', 'screen': CarpentryToolsScreen, 'color': Colors.orange},
    {'name': 'أدوات الحدادة', 'screen': BlacksmithToolsScreen, 'color': Colors.brown},
    {'name': 'الخدمات المنزلية', 'screen': HomeServicesScreen, 'color': Colors.blue},
    {'name': 'خدمات السيارات', 'screen': CarServicesScreen, 'color': Colors.red},
    {'name': 'خدمات المقاولات', 'screen': ContractingServicesScreen, 'color': Colors.green},
    {'name': 'خدمات النقل والتوصيل', 'screen': DeliveryServicesScreen, 'color': Colors.orange},
    {'name': 'خدمات التعليم والتدريب', 'screen': TrainingServicesScreen, 'color': Colors.purple},
    {'name': 'المعدات الطبية', 'screen': MedicalEquipmentScreen, 'color': Colors.red},
    {'name': 'مستحضرات التجميل', 'screen': CosmeticsScreen, 'color': Colors.pink},
    {'name': 'العناية بالشعر', 'screen': HairCareScreen, 'color': Colors.blue},
    {'name': 'العناية بالبشرة', 'screen': SkinCareScreen, 'color': Colors.green},
    {'name': 'العطور', 'screen': PerfumesScreen, 'color': Colors.amber},
    {'name': 'المواد الغذائية', 'screen': GroceriesScreen, 'color': Colors.brown},
    {'name': 'المشروبات', 'screen': BeveragesScreen, 'color': Colors.blue},
    {'name': 'الخضروات والفواكه', 'screen': FruitsVegetablesScreen, 'color': Colors.green},
    {'name': 'اللحوم والدواجن', 'screen': MeatPoultryScreen, 'color': Colors.red},
    {'name': 'الأسماك', 'screen': SeafoodScreen, 'color': Colors.cyan},
    {'name': 'منتجات الألبان', 'screen': DairyProductsScreen, 'color': Colors.white},
    {'name': 'المخبوزات', 'screen': BakeryScreen, 'color': Colors.brown},
    {'name': 'الحلويات', 'screen': DessertsScreen, 'color': Colors.pink},
    {'name': 'المكسرات', 'screen': NutsDriedFruitsScreen, 'color': Colors.green},
    {'name': 'الأغذية المعلبة', 'screen': CannedFoodScreen, 'color': Colors.blue},
    {'name': 'التوابل والبهارات', 'screen': SpicesScreen, 'color': Colors.orange},
    {'name': 'الأرز والحبوب', 'screen': RiceGrainsScreen, 'color': Colors.brown},
    {'name': 'الزيوت والدهون', 'screen': OilsFatsScreen, 'color': Colors.yellow},
    {'name': 'السكر والحلويات', 'screen': SugarSweetsScreen, 'color': Colors.pink},
    {'name': 'المشروبات الساخنة', 'screen': HotDrinksScreen, 'color': Colors.brown},
    {'name': 'المشروبات الباردة', 'screen': ColdDrinksScreen, 'color': Colors.orange},
