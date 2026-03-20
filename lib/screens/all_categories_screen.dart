import 'products_screen.dart';
import 'package:flex_yemen/models/rating_model.dart';
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
import 'categories/luxury_cars_screen.dart';
import 'categories/commercial_realestate_screen.dart';
import 'categories/consumer_electronics_screen.dart';
import 'categories/luxury_furniture_screen.dart';
import 'categories/jewelry_watches_screen.dart';
import 'categories/perfumes_makeup_screen.dart';
import 'categories/food_beverages_screen.dart';
import 'categories/baby_kids_screen.dart';
import 'categories/pets_screen.dart';
import 'categories/gifts_screen.dart';
import 'categories/sports_fitness_screen.dart';
import 'categories/stationery_screen.dart';
import 'categories/industrial_equipment_screen.dart';
import 'categories/electrical_tools_screen.dart';
import 'categories/plumbing_tools_screen.dart';
import 'categories/carpentry_tools_screen.dart';
import 'categories/blacksmith_tools_screen.dart';
import 'categories/home_services_screen.dart';
import 'categories/car_services_screen.dart';
import 'categories/contracting_services_screen.dart';
import 'categories/delivery_services_screen.dart';
import 'categories/training_services_screen.dart';
import 'categories/medical_equipment_screen.dart';
import 'categories/cosmetics_screen.dart';
import 'categories/hair_care_screen.dart';
import 'categories/skin_care_screen.dart';
import 'categories/perfumes_screen.dart';
import 'categories/groceries_screen.dart';
import 'categories/beverages_screen.dart';
import 'categories/fruits_vegetables_screen.dart';
import 'categories/meat_poultry_screen.dart';
import 'categories/seafood_screen.dart';
import 'categories/dairy_products_screen.dart';
import 'categories/bakery_screen.dart';
import 'categories/desserts_screen.dart';
import 'categories/nuts_dried_fruits_screen.dart';
import 'categories/canned_food_screen.dart';
import 'categories/spices_screen.dart';
import 'categories/rice_grains_screen.dart';
import 'categories/oils_fats_screen.dart';
import 'categories/sugar_sweets_screen.dart';
import 'categories/hot_drinks_screen.dart';
import 'categories/cold_drinks_screen.dart';
import 'categories/wedding_supplies_screen.dart';
import 'categories/graduation_parties_screen.dart';
import 'categories/birthday_supplies_screen.dart';
import 'categories/events_supplies_screen.dart';
import 'categories/traditional_food_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الأقسام'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CategorySection(title: 'الصحة والجمال', screen: HealthBeautyScreen(), color: Colors.pink),
          CategorySection(title: 'الأجهزة المنزلية', screen: HomeAppliancesScreen(), color: Colors.cyan),
          CategorySection(title: 'المطبخ والطعام', screen: KitchenFoodScreen(), color: Colors.amber),
          CategorySection(title: 'الحرف والتحف', screen: HandicraftsAntiquesScreen(), color: Colors.brown),
          CategorySection(title: 'مواد البناء', screen: ConstructionMaterialsScreen(), color: Colors.grey),
          CategorySection(title: 'الزراعة', screen: AgricultureScreen(), color: Colors.green),
          CategorySection(title: 'التعليم', screen: EducationScreen(), color: Colors.blue),
          CategorySection(title: 'السفر والسياحة', screen: TravelTourismScreen(), color: Colors.orange),
          CategorySection(title: 'المزادات', screen: AuctionsCategoryScreen(), color: Colors.red),
          CategorySection(title: 'التبرعات', screen: DonationsScreen(), color: Colors.teal),
          CategorySection(title: 'الكماليات', screen: LuxuryItemsScreen(), color: Colors.purple),
          CategorySection(title: 'المعدات الثقيلة', screen: HeavyEquipmentScreen(), color: Colors.yellow),
          CategorySection(title: 'البرمجيات', screen: SoftwareScreen(), color: Colors.indigo),
          CategorySection(title: 'الأمن والسلامة', screen: SecuritySafetyScreen(), color: Colors.grey),
          CategorySection(title: 'الطيران', screen: AviationScreen(), color: Colors.lightBlue),
          CategorySection(title: 'الموسيقى', screen: MusicScreen(), color: Colors.purple),
          CategorySection(title: 'العملات والطوابع', screen: CurrencyScreen(), color: Colors.amber),
          CategorySection(title: 'السينما', screen: CinemaScreen(), color: Colors.red),
          CategorySection(title: 'السيارات الفاخرة', screen: LuxuryCarsScreen(), color: Colors.grey),
          CategorySection(title: 'العقارات التجارية', screen: CommercialRealestateScreen(), color: Colors.blue),
          CategorySection(title: 'الإلكترونيات الاستهلاكية', screen: ConsumerElectronicsScreen(), color: Colors.red),
          CategorySection(title: 'الأثاث الفاخر', screen: LuxuryFurnitureScreen(), color: Colors.brown),
          CategorySection(title: 'المجوهرات والساعات', screen: JewelryWatchesScreen(), color: Colors.amber),
          CategorySection(title: 'العطور والمكياج', screen: PerfumesMakeupScreen(), color: Colors.pink),
          CategorySection(title: 'الأطعمة والمشروبات', screen: FoodBeveragesScreen(), color: Colors.orange),
          CategorySection(title: 'مستلزمات الأطفال', screen: BabyKidsScreen(), color: Colors.blue),
          CategorySection(title: 'الحيوانات الأليفة', screen: PetsScreen(), color: Colors.brown),
          CategorySection(title: 'الهدايا', screen: GiftsScreen(), color: Colors.red),
          CategorySection(title: 'الرياضة واللياقة', screen: SportsFitnessScreen(), color: Colors.green),
          CategorySection(title: 'القرطاسية', screen: StationeryScreen(), color: Colors.purple),
          CategorySection(title: 'المعدات الصناعية', screen: IndustrialEquipmentScreen(), color: Colors.grey),
          CategorySection(title: 'الأدوات الكهربائية', screen: ElectricalToolsScreen(), color: Colors.yellow),
          CategorySection(title: 'أدوات السباكة', screen: PlumbingToolsScreen(), color: Colors.blue),
          CategorySection(title: 'أدوات النجارة', screen: CarpentryToolsScreen(), color: Colors.orange),
          CategorySection(title: 'أدوات الحدادة', screen: BlacksmithToolsScreen(), color: Colors.brown),
          CategorySection(title: 'الخدمات المنزلية', screen: HomeServicesScreen(), color: Colors.blue),
          CategorySection(title: 'خدمات السيارات', screen: CarServicesScreen(), color: Colors.red),
          CategorySection(title: 'خدمات المقاولات', screen: ContractingServicesScreen(), color: Colors.green),
          CategorySection(title: 'خدمات النقل والتوصيل', screen: DeliveryServicesScreen(), color: Colors.orange),
          CategorySection(title: 'خدمات التعليم والتدريب', screen: TrainingServicesScreen(), color: Colors.purple),
          CategorySection(title: 'المعدات الطبية', screen: MedicalEquipmentScreen(), color: Colors.red),
          CategorySection(title: 'مستحضرات التجميل', screen: CosmeticsScreen(), color: Colors.pink),
          CategorySection(title: 'العناية بالشعر', screen: HairCareScreen(), color: Colors.blue),
          CategorySection(title: 'العناية بالبشرة', screen: SkinCareScreen(), color: Colors.green),
          CategorySection(title: 'العطور', screen: PerfumesScreen(), color: Colors.amber),
          CategorySection(title: 'المواد الغذائية', screen: GroceriesScreen(), color: Colors.brown),
          CategorySection(title: 'المشروبات', screen: BeveragesScreen(), color: Colors.blue),
          CategorySection(title: 'الخضروات والفواكه', screen: FruitsVegetablesScreen(), color: Colors.green),
          CategorySection(title: 'اللحوم والدواجن', screen: MeatPoultryScreen(), color: Colors.red),
          CategorySection(title: 'الأسماك', screen: SeafoodScreen(), color: Colors.cyan),
          CategorySection(title: 'منتجات الألبان', screen: DairyProductsScreen(), color: Colors.white),
          CategorySection(title: 'المخبوزات', screen: BakeryScreen(), color: Colors.brown),
          CategorySection(title: 'الحلويات', screen: DessertsScreen(), color: Colors.pink),
          CategorySection(title: 'المكسرات', screen: NutsDriedFruitsScreen(), color: Colors.green),
          CategorySection(title: 'الأغذية المعلبة', screen: CannedFoodScreen(), color: Colors.blue),
          CategorySection(title: 'التوابل والبهارات', screen: SpicesScreen(), color: Colors.orange),
          CategorySection(title: 'الأرز والحبوب', screen: RiceGrainsScreen(), color: Colors.brown),
          CategorySection(title: 'الزيوت والدهون', screen: OilsFatsScreen(), color: Colors.yellow),
          CategorySection(title: 'السكر والحلويات', screen: SugarSweetsScreen(), color: Colors.pink),
          CategorySection(title: 'المشروبات الساخنة', screen: HotDrinksScreen(), color: Colors.brown),
          CategorySection(title: 'المشروبات الباردة', screen: ColdDrinksScreen(), color: Colors.orange),
          CategorySection(title: 'تجهيزات الأعراس', screen: WeddingSuppliesScreen(), color: Colors.pink),
          CategorySection(title: 'حفلات وتخرج', screen: GraduationPartiesScreen(), color: Colors.blue),
          CategorySection(title: 'أعياد الميلاد', screen: BirthdaySuppliesScreen(), color: Colors.red),
          CategorySection(title: 'تجهيزات الحفلات', screen: EventsSuppliesScreen(), color: Colors.green),
          CategorySection(title: 'المأكولات الشعبية', screen: TraditionalFoodScreen(), color: Colors.orange),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final Widget screen;
  final Color color;

  const CategorySection({
    super.key,
    required this.title,
    required this.screen,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => screen),
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
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.category, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
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
  }
}
