import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/ad_card.dart';
import '../widgets/loading_widget.dart';
import '../models/ad_model.dart';
import 'all_ads_screen.dart';
import 'ad_detail_screen.dart';
import 'search_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  bool _isLoading = true;
  List<AdModel> _featuredAds = [];
  List<AdModel> _auctionAds = [];

  // بيانات وهمية للعرض
  final List<Map<String, dynamic>> _sliderData = [
    {
      'title': 'إعلانات حصرية للتجار',
      'subtitle': 'اعرض منتجاتك لآلاف العملاء',
      'color': const Color(0xFF6C63FF),
      'icon': Icons.store,
    },
    {
      'title': 'VIP عروض',
      'subtitle': 'خصومات حصرية تصل إلى 50%',
      'color': const Color(0xFFFF6B6B),
      'icon': Icons.local_offer,
    },
    {
      'title': 'عروض أفضل المطاعم',
      'subtitle': 'اكتشف أشهى المأكولات',
      'color': const Color(0xFF4ECDC4),
      'icon': Icons.restaurant,
    },
    {
      'title': 'مزادات السيارات والعقارات',
      'subtitle': 'فرص استثمارية فريدة',
      'color': const Color(0xFFFFE66D),
      'icon': Icons.directions_car,
    },
    {
      'title': 'إعلانات المنصة',
      'subtitle': 'تابع آخر أخبار Flex Yemen',
      'color': const Color(0xFF95E1D3),
      'icon': Icons.campaign,
    },
  ];

  final List<Map<String, dynamic>> _quickCategories = [
    {'name': 'معلمات', 'icon': Icons.construction, 'color': Color(0xFFFF9800)},
    {'name': 'عقارات', 'icon': Icons.apartment, 'color': Color(0xFF4CAF50)},
    {'name': 'سفر', 'icon': Icons.flight, 'color': Color(0xFF2196F3)},
    {'name': 'شحن', 'icon': Icons.local_shipping, 'color': Color(0xFF9C27B0)},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Color(0xFFE91E63)},
  ];

  final List<Map<String, dynamic>> _realEstateCategories = [
    {'name': 'شقق الإيجار', 'icon': Icons.apartment, 'color': Color(0xFF2196F3)},
    {'name': 'فلل البيع', 'icon': Icons.villa, 'color': Color(0xFF4CAF50)},
    {'name': 'أراضي', 'icon': Icons.terrain, 'color': Color(0xFFFF9800)},
    {'name': 'مكافآت', 'icon': Icons.business, 'color': Color(0xFF9C27B0)},
    {'name': 'محطات', 'icon': Icons.local_gas_station, 'color': Color(0xFFF44336)},
    {'name': 'مقاولات', 'icon': Icons.engineering, 'color': Color(0xFF00BCD4)},
    {'name': 'ديكور', 'icon': Icons.design_services, 'color': Color(0xFFFFEB3B)},
  ];

  final List<Map<String, dynamic>> _techCategories = [
    {'name': 'هواتف', 'icon': Icons.smartphone, 'color': Color(0xFF9C27B0)},
    {'name': 'لابتوب', 'icon': Icons.laptop, 'color': Color(0xFF673AB7)},
    {'name': 'ستارلينك', 'icon': Icons.wifi, 'color': Color(0xFF3F51B5)},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': Color(0xFF2196F3)},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // محاكاة تحميل البيانات
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _featuredAds = _getMockAds();
      _auctionAds = _getMockAuctions();
      _isLoading = false;
    });
  }

  List<AdModel> _getMockAds() {
    return [
      AdModel(
        id: '1',
        title: 'آيفون 15 برو ماكس 256GB',
        description: 'جديد بالكامل مع الضمان',
        price: 450000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'إلكترونيات',
        subCategory: 'هواتف',
        city: 'صنعاء',
        sellerId: 'seller1',
        sellerName: 'متجر التقنية',
        sellerRating: 4.8,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isOffer: true,
        discountPercentage: 15,
        oldPrice: '530,000 ر.ي',
      ),
      AdModel(
        id: '2',
        title: 'سيارة تويوتا كامري 2020',
        description: 'نظيفة جداً، ماشية 50 ألف',
        price: 8500000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'سيارات',
        subCategory: 'تويوتا',
        city: 'عدن',
        sellerId: 'seller2',
        sellerName: 'معرض السيارات',
        sellerRating: 4.5,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      AdModel(
        id: '3',
        title: 'شقة للبيع في حدة',
        description: '3 غرف، 2 حمام، صالة كبيرة',
        price: 35000000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'عقارات',
        subCategory: 'شقق',
        city: 'صنعاء',
        sellerId: 'seller3',
        sellerName: 'مكتب العقارات',
        sellerRating: 4.9,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isFeatured: true,
      ),
      AdModel(
        id: '4',
        title: 'لابتوب ماك بوك برو',
        description: 'M1 Pro، 16GB RAM، 512GB SSD',
        price: 1200000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'إلكترونيات',
        subCategory: 'لابتوب',
        city: 'تعز',
        sellerId: 'seller4',
        sellerName: 'Apple Store',
        sellerRating: 5.0,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        isOffer: true,
        discountPercentage: 10,
        oldPrice: '1,350,000 ر.ي',
      ),
    ];
  }

  List<AdModel> _getMockAuctions() {
    return [
      AdModel(
        id: 'auction1',
        title: 'جندية صيفاني قديمة',
        description: 'أثرية نادرة',
        price: 150000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'مزادات',
        subCategory: 'جنابي',
        city: 'صنعاء',
        sellerId: 'seller5',
        sellerName: 'مزاد الجنابي',
        sellerRating: 4.7,
        createdAt: DateTime.now(),
        isAuction: true,
        auctionEndTime: DateTime.now().add(const Duration(days: 2)),
        currentBid: 150000,
        bidCount: 12,
      ),
      AdModel(
        id: 'auction2',
        title: 'سيف قديم أثري',
        description: 'من العصر العثماني',
        price: 250000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'مزادات',
        subCategory: 'تحف',
        city: 'المكلا',
        sellerId: 'seller6',
        sellerName: 'مزاد التحف',
        sellerRating: 4.9,
        createdAt: DateTime.now(),
        isAuction: true,
        auctionEndTime: DateTime.now().add(const Duration(hours: 12)),
        currentBid: 250000,
        bidCount: 8,
      ),
      AdModel(
        id: 'auction3',
        title: 'سجادة يدوية فارسية',
        description: 'صناعة يدوية أصلية',
        price: 500000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'مزادات',
        subCategory: 'سجاد',
        city: 'صنعاء',
        sellerId: 'seller7',
        sellerName: 'مزاد السجاد',
        sellerRating: 4.6,
        createdAt: DateTime.now(),
        isAuction: true,
        auctionEndTime: DateTime.now().add(const Duration(days: 3)),
        currentBid: 500000,
        bidCount: 5,
      ),
      AdModel(
        id: 'auction4',
        title: 'تحفة نحاسية نادرة',
        description: 'نحت يدوي دقيق',
        price: 75000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'مزادات',
        subCategory: 'تحف',
        city: 'إب',
        sellerId: 'seller8',
        sellerName: 'مزاد النحاس',
        sellerRating: 4.4,
        createdAt: DateTime.now(),
        isAuction: true,
        auctionEndTime: DateTime.now().add(const Duration(hours: 6)),
        currentBid: 75000,
        bidCount: 15,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: AppTheme.goldColor,
        child: CustomScrollView(
          slivers: [
            // الشريط العلوي
            SliverToBoxAdapter(
              child: CustomAppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // المحتوى
            if (_isLoading)
              const SliverFillRemaining(
                child: Center(child: LoadingWidget()),
              )
            else
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // السلايدر
                    _buildSlider(),

                    const SizedBox(height: 24),

                    // قسم "مزيد من ما تريد"
                    _buildSectionTitle('مزيد من ما تريد', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    _buildQuickCategories(),

                    const SizedBox(height: 24),

                    // قسم مزاد الجنابي
                    _buildSectionTitle('مزاد الجنابي الأسبوعي', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    _buildAuctionGrid(),

                    const SizedBox(height: 24),

                    // قسم العقارات
                    _buildSectionTitle('العقارات والاستثمارات', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    _buildRealEstateCategories(),

                    const SizedBox(height: 24),

                    // قسم الإلكترونيات
                    _buildSectionTitle('عالم الإلكترونيات والتقنية', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    _buildTechCategories(),

                    const SizedBox(height: 24),

                    // قسم الإعلانات المميزة
                    _buildSectionTitle('إعلانات مميزة', onSeeAll: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AllAdsScreen()),
                      );
                    }),
                    const SizedBox(height: 12),
                    _buildFeaturedAds(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _sliderData.length,
          itemBuilder: (context, index, realIndex) {
            final slide = _sliderData[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    slide['color'],
                    slide['color'].withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // أيقونة خلفية
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      slide['icon'],
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  // المحتوى
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            slide['icon'],
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['title'],
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['subtitle'],
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).fadeIn(delay: Duration(milliseconds: index * 100));
          },
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        AnimatedSmoothIndicator(
          activeIndex: _currentSlide,
          count: _sliderData.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppTheme.goldColor,
            dotColor: Colors.grey.withOpacity(0.3),
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkText
                  : AppTheme.lightText,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Row(
              children: [
                Text(
                  'المزيد',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    color: AppTheme.goldColor,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                  color: AppTheme.goldColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickCategories.length,
        itemBuilder: (context, index) {
          final category = _quickCategories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuctionGrid() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _auctionAds.length,
        itemBuilder: (context, index) {
          final ad = _auctionAds[index];
          return SizedBox(
            width: 180,
            child: AuctionCard(
              ad: ad,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AdDetailScreen(ad: ad),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRealEstateCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _realEstateCategories.length,
        itemBuilder: (context, index) {
          final category = _realEstateCategories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 11,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
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

  Widget _buildTechCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _techCategories.length,
        itemBuilder: (context, index) {
          final category = _techCategories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 85,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedAds() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _featuredAds.length,
        itemBuilder: (context, index) {
          final ad = _featuredAds[index];
          return AdCard(
            ad: ad,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AdDetailScreen(ad: ad),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
