import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../models/ad_model.dart';
import 'ad_detail_screen.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});

  final List<AdModel> _ads = const [
    AdModel(id: '1', title: 'آيفون 15 برو ماكس', description: 'جديد', price: 450000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'إلكترونيات', subCategory: 'هواتف', city: 'صنعاء', sellerId: '1', sellerName: 'متجر التقنية', sellerRating: 4.8, createdAt: null),
    AdModel(id: '2', title: 'سيارة تويوتا', description: '2020', price: 8500000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'سيارات', subCategory: 'تويوتا', city: 'عدن', sellerId: '2', sellerName: 'معرض السيارات', sellerRating: 4.5, createdAt: null),
    AdModel(id: '3', title: 'شقة للبيع', description: '3 غرف', price: 35000000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'عقارات', subCategory: 'شقق', city: 'صنعاء', sellerId: '3', sellerName: 'مكتب العقارات', sellerRating: 4.9, createdAt: null),
    AdModel(id: '4', title: 'لابتوب ماك بوك', description: 'M1', price: 1200000, currency: 'YER', images: ['https://via.placeholder.com/300'], category: 'إلكترونيات', subCategory: 'لابتوب', city: 'تعز', sellerId: '4', sellerName: 'Apple Store', sellerRating: 5.0, createdAt: null),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الإعلانات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _ads.length,
        itemBuilder: (context, index) {
          final ad = _ads[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdDetailScreen(ad: ad))),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(ad.images[0], fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ad.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const Spacer(),
                          Text('${ad.formattedPrice} ${ad.currencySymbol}', style: const TextStyle(color: AppTheme.goldColor)),
                          Text(ad.city, style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
