import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'all_ads_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'عرض خاص',
      'subtitle': 'عروض أفضل المطاعم',
      'desc': 'اكتشف أشهى المأكولات',
      'color': Colors.purple,
      'icon': Icons.restaurant,
      'gradient': [Colors.purple, Colors.deepPurple],
    },
    {
      'title': 'VIP عروض',
      'subtitle': 'خصومات حصرية',
      'desc': 'تصل إلى 50%',
      'color': Colors.amber,
      'icon': Icons.star,
      'gradient': [Colors.amber, Colors.orange],
    },
    {
      'title': 'مزاد الجنابي',
      'subtitle': 'سيف قديم أثري',
      'desc': 'السعر الحالي 150K',
      'color': Colors.red,
      'icon': Icons.timer,
      'gradient': [Colors.red, Colors.redAccent],
    },
    {
      'title': 'مزاد السيارات',
      'subtitle': 'شاص 2024',
      'desc': 'السعر الحالي 35,000',
      'color': Colors.blue,
      'icon': Icons.directions_car,
      'gradient': [Colors.blue, Colors.blueAccent],
    },
    {
      'title': 'مزاد العقارات',
      'subtitle': 'شقة في حدة',
      'desc': 'السعر الحالي 35M',
      'color': Colors.green,
      'icon': Icons.home,
      'gradient': [Colors.green, Colors.teal],
    },
  ];

  final List<Map<String, dynamic>> _quickCategories = [
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.brown},
    {'name': 'ملابس', 'icon': Icons.checkroom, 'color': Colors.purple},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.orange},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Colors.teal},
    {'name': 'حيوانات', 'icon': Icons.pets, 'color': Colors.pink},
    {'name': 'رياضة', 'icon': Icons.sports, 'color': Colors.green},
    {'name': 'صحة', 'icon': Icons.health_and_safety, 'color': Colors.red},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.blue},
    {'name': 'جمال', 'icon': Icons.face, 'color': Colors.pink},
    {'name': 'مطبخ', 'icon': Icons.kitchen, 'color': Colors.orange},
    {'name': 'كتب', 'icon': Icons.book, 'color': Colors.brown},
  ];

  final List<Map<String, dynamic>> _randomAds = [
    // الإلكترونيات (8 إعلانات)
    {'title': 'آيفون 15 برو ماكس', 'price': '450,000 ر.ي', 'location': 'صنعاء', 'image': Icons.phone_iphone, 'color': Colors.blue},
    {'title': 'سامسونج S24 الترا', 'price': '380,000 ر.ي', 'location': 'عدن', 'image': Icons.phone_android, 'color': Colors.purple},
    {'title': 'ماك بوك برو M3', 'price': '1,800,000 ر.ي', 'location': 'صنعاء', 'image': Icons.laptop, 'color': Colors.grey},
    {'title': 'آيباد برو 12.9', 'price': '350,000 ر.ي', 'location': 'تعز', 'image': Icons.tablet, 'color': Colors.cyan},
    {'title': 'ساعة أبل الترا 2', 'price': '95,000 ر.ي', 'location': 'صنعاء', 'image': Icons.watch, 'color': Colors.amber},
    {'title': 'سماعات ايربودز برو', 'price': '45,000 ر.ي', 'location': 'عدن', 'image': Icons.headphones, 'color': Colors.red},
    {'title': 'بلاي ستيشن 5', 'price': '250,000 ر.ي', 'location': 'صنعاء', 'image': Icons.sports_esports, 'color': Colors.blue},
    {'title': 'كاميرا كانون', 'price': '320,000 ر.ي', 'location': 'المكلا', 'image': Icons.camera_alt, 'color': Colors.brown},
    
    // السيارات (8 إعلانات)
    {'title': 'تويوتا كامري 2020', 'price': '8,500,000 ر.ي', 'location': 'عدن', 'image': Icons.directions_car, 'color': Colors.red},
    {'title': 'شاص 2024', 'price': '12,500,000 ر.ي', 'location': 'صنعاء', 'image': Icons.directions_car, 'color': Colors.orange},
    {'title': 'مرسيدس E300', 'price': '15,000,000 ر.ي', 'location': 'صنعاء', 'image': Icons.directions_car, 'color': Colors.grey},
    {'title': 'هونداي النترا', 'price': '5,500,000 ر.ي', 'location': 'الحديدة', 'image': Icons.directions_car, 'color': Colors.blue},
    {'title': 'لاند كروزر 2023', 'price': '22,000,000 ر.ي', 'location': 'المكلا', 'image': Icons.directions_car, 'color': Colors.orange},
    {'title': 'باترول 2022', 'price': '18,000,000 ر.ي', 'location': 'صنعاء', 'image': Icons.directions_car, 'color': Colors.green},
    {'title': 'لكزس LX600', 'price': '25,000,000 ر.ي', 'location': 'عدن', 'image': Icons.directions_car, 'color': Colors.black},
    {'title': 'بي إم دبليو X5', 'price': '16,500,000 ر.ي', 'location': 'صنعاء', 'image': Icons.directions_car, 'color': Colors.blue},
    
    // العقارات (8 إعلانات)
    {'title': 'شقة في حدة', 'price': '35,000,000 ر.ي', 'location': 'صنعاء', 'image': Icons.home, 'color': Colors.green},
    {'title': 'فيلا في المكلا', 'price': '65,000,000 ر.ي', 'location': 'المكلا', 'image': Icons.villa, 'color': Colors.amber},
    {'title': 'أرض في مأرب', 'price': '25,000,000 ر.ي', 'location': 'مأرب', 'image': Icons.landscape, 'color': Colors.brown},
    {'title': 'محل تجاري', 'price': '12,000,000 ر.ي', 'location': 'عدن', 'image': Icons.store, 'color': Colors.purple},
    {'title': 'مكتب في تعز', 'price': '8,500,000 ر.ي', 'location': 'تعز', 'image': Icons.business, 'color': Colors.blue},
    {'title': 'مستودع', 'price': '15,000,000 ر.ي', 'location': 'الحديدة', 'image': Icons.warehouse, 'color': Colors.grey},
    {'title': 'شقة في عدن', 'price': '28,000,000 ر.ي', 'location': 'عدن', 'image': Icons.apartment, 'color': Colors.cyan},
    {'title': 'بيت في إب', 'price': '18,000,000 ر.ي', 'location': 'إب', 'image': Icons.house, 'color': Colors.orange},
    
    // الأثاث (6 إعلانات)
    {'title': 'غرفة نوم كاملة', 'price': '650,000 ر.ي', 'location': 'صنعاء', 'image': Icons.bed, 'color': Colors.brown},
    {'title': 'مجلس عربي', 'price': '450,000 ر.ي', 'location': 'صنعاء', 'image': Icons.chair, 'color': Colors.orange},
    {'title': 'طاولة طعام', 'price': '120,000 ر.ي', 'location': 'عدن', 'image': Icons.dining, 'color': Colors.green},
    {'title': 'كنب مودرن', 'price': '280,000 ر.ي', 'location': 'تعز', 'image': Icons.weekend, 'color': Colors.purple},
    {'title': 'مكتبة', 'price': '85,000 ر.ي', 'location': 'صنعاء', 'image': Icons.book, 'color': Colors.brown},
    {'title': 'غرفة جلوس', 'price': '320,000 ر.ي', 'location': 'عدن', 'image': Icons.chair, 'color': Colors.amber},
    
    // الملابس (6 إعلانات)
    {'title': 'ثوب رجالي', 'price': '15,000 ر.ي', 'location': 'صنعاء', 'image': Icons.man, 'color': Colors.blue},
    {'title': 'عباية نسائية', 'price': '25,000 ر.ي', 'location': 'عدن', 'image': Icons.woman, 'color': Colors.pink},
    {'title': 'أحذية رياضية', 'price': '12,000 ر.ي', 'location': 'تعز', 'image': Icons.sports_handball, 'color': Colors.red},
    {'title': 'ساعة رجالية', 'price': '8,000 ر.ي', 'location': 'صنعاء', 'image': Icons.watch, 'color': Colors.amber},
    {'title': 'نظارة شمسية', 'price': '5,000 ر.ي', 'location': 'عدن', 'image': Icons.sunny, 'color': Colors.black},
    {'title': 'حقيبة جلدية', 'price': '18,000 ر.ي', 'location': 'صنعاء', 'image': Icons.bag, 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          // السلايدر المتحرك
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CarouselSlider.builder(
                  itemCount: _slides.length,
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() => _currentSlide = index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final slide = _slides[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                                    slide['title'],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontFamily: 'Changa',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  slide['subtitle'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Changa',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  slide['desc'],
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
                const SizedBox(height: 12),
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

          // شريط الأقسام المتحرك
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'جميع الأقسام',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Changa',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllAdsScreen()),
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

          // شريط الأقسام الأفقي
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _quickCategories.length,
                itemBuilder: (context, index) {
                  final cat = _quickCategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllAdsScreen()),
                      );
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (cat['color'] as Color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              cat['icon'] as IconData,
                              color: cat['color'] as Color,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat['name'],
                            style: const TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // عنوان الإعلانات المميزة
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'إعلانات مميزة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa',
                ),
              ),
            ),
          ),

          // الإعلانات العشوائية
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ad = _randomAds[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllAdsScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (ad['color'] as Color).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: (ad['color'] as Color).withOpacity(0.2),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Icon(
                                ad['image'] as IconData,
                                size: 50,
                                color: ad['color'] as Color,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ad['title'],
                                    style: const TextStyle(
                                      fontFamily: 'Changa',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    ad['price'],
                                    style: const TextStyle(
                                      color: AppTheme.goldColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      fontFamily: 'Changa',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 10, color: Colors.grey),
                                      const SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          ad['location'],
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                            fontFamily: 'Changa',
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _randomAds.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
