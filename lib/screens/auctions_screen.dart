import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../models/ad_model.dart';
import 'ad_detail_screen.dart';

class AuctionsScreen extends StatelessWidget {
  const AuctionsScreen({super.key});

  final List<AdModel> _auctions = const [
    AdModel(id: '1', title: 'سيف قديم أثري', description: 'نادر', price: 250000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'مزادات', subCategory: 'تحف', city: 'صنعاء', sellerId: '1', sellerName: 'مزاد التحف', sellerRating: 4.9, createdAt: null, isAuction: true, bidCount: 8),
    AdModel(id: '2', title: 'جندية صيفاني قديمة', description: 'أثرية', price: 150000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'مزادات', subCategory: 'جنابي', city: 'صنعاء', sellerId: '2', sellerName: 'مزاد الجنابي', sellerRating: 4.7, createdAt: null, isAuction: true, bidCount: 12),
    AdModel(id: '3', title: 'سجادة يدوية', description: 'فارسية', price: 500000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'مزادات', subCategory: 'سجاد', city: 'المكلا', sellerId: '3', sellerName: 'مزاد السجاد', sellerRating: 4.6, createdAt: null, isAuction: true, bidCount: 5),
    AdModel(id: '4', title: 'تحفة نحاسية', description: 'نادرة', price: 75000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'مزادات', subCategory: 'تحف', city: 'إب', sellerId: '4', sellerName: 'مزاد النحاس', sellerRating: 4.4, createdAt: null, isAuction: true, bidCount: 15),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المزادات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _auctions.length,
        itemBuilder: (context, index) {
          final ad = _auctions[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdDetailScreen(ad: ad))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
                    child: Image.network(ad.images[0], width: 100, height: 100, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(ad.title, style: const TextStyle(fontWeight: FontWeight.bold))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                                child: Text('${ad.bidCount} عروض', style: const TextStyle(fontSize: 10, color: Colors.blue)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('السعر الحالي: ${ad.formattedPrice} ${ad.currencySymbol}', style: const TextStyle(color: AppTheme.goldColor)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.timer, size: 14, color: Colors.red),
                              const SizedBox(width: 4),
                              Text('ينتهي خلال 11:59', style: const TextStyle(color: Colors.red, fontSize: 12)),
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
      ),
    );
  }
}
