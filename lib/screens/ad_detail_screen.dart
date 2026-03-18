import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/ad_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetailScreen extends StatefulWidget {
  final AdModel ad;
  const AdDetailScreen({super.key, required this.ad});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  final List<String> _sampleImages = [
    'https://images.unsplash.com/photo-1621007947382-bb3c3968e3bb?w=400',
    'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
    'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
  ];

  final List<Map<String, dynamic>> _similarAds = [
    {'title': 'آيفون 15 برو ماكس', 'price': '450,000', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200'},
    {'title': 'سامسونج S24 الترا', 'price': '380,000', 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=200'},
    {'title': 'ماك بوك برو M3', 'price': '1,800,000', 'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200'},
  ];

  final List<Map<String, dynamic>> _reviews = [
    {'user': 'أحمد محمد', 'rating': 5, 'comment': 'منتج ممتاز والتوصيل سريع', 'date': 'منذ يومين'},
    {'user': 'فاطمة علي', 'rating': 4, 'comment': 'جودة ممتازة، سعر مناسب', 'date': 'منذ 5 أيام'},
    {'user': 'خالد سالم', 'rating': 5, 'comment': 'تعامل راقي، أنصح بالتعامل', 'date': 'منذ أسبوع'},
  ];

  void _toggleFavorite() => setState(() => _isFavorite = !_isFavorite);

  Future<void> _launchWhatsApp() async {
    final phone = widget.ad.sellerPhone ?? '';
    final url = 'https://wa.me/$phone?text=${Uri.encodeComponent('مرحباً، أنا مهتم بإعلانك: ${widget.ad.title}')}';
    if (await canLaunchUrl(Uri.parse(url))) await launchUrl(Uri.parse(url));
  }

  Future<void> _makePhoneCall() async {
    final phone = widget.ad.sellerPhone ?? '';
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ad = widget.ad;
    final images = ad.images.isNotEmpty ? ad.images : _sampleImages;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar مدمج مع الصور
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // كاروسيل الصور
                  CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: images.length > 1,
                      onPageChanged: (index, _) => setState(() => _currentImageIndex = index),
                    ),
                    itemBuilder: (context, index, _) {
                      return CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: Colors.grey[300]),
                        errorWidget: (_, __, ___) => Container(color: Colors.grey, child: const Icon(Icons.broken_image)),
                      );
                    },
                  ),
                  // التدرج للقراءة
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                    ),
                  ),
                  // مؤشر الصفحات
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (i) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == i
                              ? AppTheme.goldColor
                              : Colors.white.withOpacity(0.5),
                        ),
                      )),
                    ),
                  ),
                  // أزرار في الأعلى
                  Positioned(
                    top: 40,
                    right: 16,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                          onPressed: _toggleFavorite,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // محتوى الإعلان
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          ad.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${ad.formattedPrice} ${ad.currencySymbol}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // الموقع والوقت
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(ad.city, style: TextStyle(color: Colors.grey[500])),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(ad.timeAgo, style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // معلومات البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.person, color: AppTheme.goldColor, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ad.sellerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 14),
                                  const SizedBox(width: 2),
                                  Text('${ad.sellerRating}'),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.verified, color: Colors.blue, size: 14),
                                  const Text(' موثوق'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat, color: AppTheme.goldColor),
                              onPressed: _launchWhatsApp,
                            ),
                            IconButton(
                              icon: const Icon(Icons.phone, color: AppTheme.goldColor),
                              onPressed: _makePhoneCall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // الوصف
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 8),
                  Text(ad.description, style: const TextStyle(fontSize: 14, height: 1.5)),
                  const SizedBox(height: 24),

                  // إعلانات مشابهة
                  const Text('إعلانات مشابهة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _similarAds.length,
                      itemBuilder: (_, i) => Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: CachedNetworkImage(
                                  imageUrl: _similarAds[i]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_similarAds[i]['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text('${_similarAds[i]['price']} ر.ي', style: const TextStyle(color: AppTheme.goldColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // التقييمات
                  const Text('التقييمات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 12),
                  ..._reviews.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 20, backgroundColor: Colors.grey[300], child: const Icon(Icons.person, size: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(r['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Row(children: List.generate(5, (i) => Icon(i < r['rating'] ? Icons.star : Icons.star_border, color: Colors.amber, size: 14))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(r['comment']),
                              const SizedBox(height: 2),
                              Text(r['date'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 16),
                  // زر الإبلاغ
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.flag, color: Colors.red),
                      label: const Text('الإبلاغ عن الإعلان', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
