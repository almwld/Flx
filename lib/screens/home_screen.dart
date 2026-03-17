import 'categories/games_screen.dart';
import 'categories/wedding_supplies_screen.dart';
import 'categories/graduation_parties_screen.dart';
import 'categories/birthday_supplies_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'all_categories_screen.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'إعلانات حصرية للتجار',
      'subtitle': 'احصل على أفضل العروض التجارية',
      'color': Colors.purple,
      'icon': Icons.business,
      'gradient': [Colors.purple, Colors.deepPurple],
    },
    {
      'title': 'VIP عروض',
      'subtitle': 'عروض خاصة للأعضاء المميزين',
      'color': Colors.amber,
      'icon': Icons.star,
      'gradient': [Colors.amber, Colors.orange],
    },
    {
      'title': 'عروض أفضل المطاعم',
      'subtitle': 'اكتشف أشهى المأكولات',
      'color': Colors.red,
      'icon': Icons.restaurant,
      'gradient': [Colors.red, Colors.redAccent],
    },
    {
      'title': 'مزادات السيارات والعقارات',
      'subtitle': 'الجنابي والأشياء الثمينة',
      'color': Colors.blue,
      'icon': Icons.directions_car,
      'gradient': [Colors.blue, Colors.blueAccent],
    },
    {
      'title': 'إعلانات المنصة',
      'subtitle': 'تابع آخر أخبار وإعلاناتنا',
      'color': Colors.green,
      'icon': Icons.campaign,
      'gradient': [Colors.green, Colors.teal],
    },
  ];

  final List<Map<String, dynamic>> _mainCategories = [
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.blue, 'screen': ConsumerElectronicsScreen()},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red, 'screen': LuxuryCarsScreen()},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green, 'screen': CommercialRealestateScreen()},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.brown, 'screen': LuxuryFurnitureScreen()},
    {'name': 'ملابس', 'icon': Icons.checkroom, 'color': Colors.purple, 'screen': CosmeticsScreen()},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.orange, 'screen': TraditionalFoodScreen()},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Colors.teal, 'screen': HomeServicesScreen()},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': Colors.pink, 'screen': PetsScreen()},
    {'name': 'رياضة', 'icon': Icons.sports, 'color': Colors.green, 'screen': SportsFitnessScreen()},
    {'name': 'كتب', 'icon': Icons.book, 'color': Colors.brown, 'screen': StationeryScreen()},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'screen': GamesScreen()},
    {'name': 'صحة', 'icon': Icons.health_and_safety, 'color': Colors.blue, 'screen': MedicalEquipmentScreen()},
    {'name': 'جمال', 'icon': Icons.face, 'color': Colors.pink, 'screen': HealthBeautyScreen()},
    {'name': 'هدايا', 'icon': Icons.card_giftcard, 'color': Colors.red, 'screen': GiftsScreen()},
    {'name': 'مطبخ', 'icon': Icons.kitchen, 'color': Colors.orange, 'screen': KitchenFoodScreen()},
    {'name': 'أجهزة', 'icon': Icons.kitchen, 'color': Colors.cyan, 'screen': HomeAppliancesScreen()},
    {'name': 'تحف', 'icon': Icons.history, 'color': Colors.brown, 'screen': HandicraftsAntiquesScreen()},
    {'name': 'بناء', 'icon': Icons.construction, 'color': Colors.grey, 'screen': ConstructionMaterialsScreen()},
    {'name': 'زراعة', 'icon': Icons.agriculture, 'color': Colors.green, 'screen': AgricultureScreen()},
    {'name': 'تعليم', 'icon': Icons.school, 'color': Colors.blue, 'screen': EducationScreen()},
    {'name': 'سفر', 'icon': Icons.flight, 'color': Colors.orange, 'screen': TravelTourismScreen()},
    {'name': 'مزادات', 'icon': Icons.gavel, 'color': Colors.red, 'screen': AuctionsCategoryScreen()},
    {'name': 'تبرعات', 'icon': Icons.favorite, 'color': Colors.pink, 'screen': DonationsScreen()},
    {'name': 'كماليات', 'icon': Icons.diamond, 'color': Colors.amber, 'screen': LuxuryItemsScreen()},
    {'name': 'معدات', 'icon': Icons.precision_manufacturing, 'color': Colors.grey, 'screen': HeavyEquipmentScreen()},
    {'name': 'برمجيات', 'icon': Icons.computer, 'color': Colors.indigo, 'screen': SoftwareScreen()},
    {'name': 'أمن', 'icon': Icons.security, 'color': Colors.grey, 'screen': SecuritySafetyScreen()},
    {'name': 'طيران', 'icon': Icons.flight, 'color': Colors.blue, 'screen': AviationScreen()},
    {'name': 'موسيقى', 'icon': Icons.music_note, 'color': Colors.purple, 'screen': MusicScreen()},
    {'name': 'عملات', 'icon': Icons.monetization_on, 'color': Colors.amber, 'screen': CurrencyScreen()},
    {'name': 'سينما', 'icon': Icons.movie, 'color': Colors.red, 'screen': CinemaScreen()},
    {'name': 'مجوهرات', 'icon': Icons.diamond, 'color': Colors.amber, 'screen': JewelryWatchesScreen()},
    {'name': 'عطور', 'icon': Icons.emoji_emotions, 'color': Colors.pink, 'screen': PerfumesScreen()},
    {'name': 'أطعمة', 'icon': Icons.fastfood, 'color': Colors.orange, 'screen': FoodBeveragesScreen()},
    {'name': 'أطفال', 'icon': Icons.child_care, 'color': Colors.blue, 'screen': BabyKidsScreen()},
    {'name': 'نقل', 'icon': Icons.local_shipping, 'color': Colors.green, 'screen': DeliveryServicesScreen()},
    {'name': 'تدريب', 'icon': Icons.school, 'color': Colors.purple, 'screen': TrainingServicesScreen()},
    {'name': 'سباكة', 'icon': Icons.plumbing, 'color': Colors.blue, 'screen': PlumbingToolsScreen()},
    {'name': 'نجارة', 'icon': Icons.handyman, 'color': Colors.orange, 'screen': CarpentryToolsScreen()},
    {'name': 'حدادة', 'icon': Icons.construction, 'color': Colors.grey, 'screen': BlacksmithToolsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CarouselSlider.builder(
                  itemCount: _slides.length,
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    viewportFraction: 0.85,
                    onPageChanged: (index, reason) {
                      setState(() => _currentSlide = index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final slide = _slides[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: slide['gradient'],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: slide['color'].withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -20,
                            bottom: -20,
                            child: Icon(
                              slide['icon'],
                              size: 120,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'عرض خاص',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12,
                                      fontFamily: 'Changa',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  slide['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Changa',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  slide['subtitle'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                    fontFamily: 'Changa',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                AnimatedSmoothIndicator(
                  activeIndex: _currentSlide,
                  count: _slides.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppTheme.goldColor,
                    dotColor: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 8,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'جميع الأقسام',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Changa',
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllCategoriesScreen()),
                      );
                    },
                    child: const Text(
                      'عرض الكل',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        color: AppTheme.goldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = _mainCategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => category['screen']),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
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
                          const SizedBox(height: 6),
                          Text(
                            category['name'],
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
                childCount: _mainCategories.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
