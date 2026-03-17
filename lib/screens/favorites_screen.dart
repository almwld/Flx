import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'ad_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, dynamic>> _favorites = const [
    {'id': '1', 'title': 'آيفون 15 برو ماكس', 'price': '450,000 ر.ي', 'image': 'https://via.placeholder.com/100', 'location': 'صنعاء'},
    {'id': '2', 'title': 'سيارة تويوتا كامري', 'price': '8,500,000 ر.ي', 'image': 'https://via.placeholder.com/100', 'location': 'عدن'},
    {'id': '3', 'title': 'شقة في حدة', 'price': '35,000,000 ر.ي', 'image': 'https://via.placeholder.com/100', 'location': 'صنعاء'},
    {'id': '4', 'title': 'ماك بوك برو M1', 'price': '1,200,000 ر.ي', 'image': 'https://via.placeholder.com/100', 'location': 'تعز'},
    {'id': '5', 'title': 'ساعة أبل الترا', 'price': '95,000 ر.ي', 'image': 'https://via.placeholder.com/100', 'location': 'صنعاء'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المفضلة'),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('لا توجد عناصر في المفضلة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 8),
                  const Text('أضف إعلاناتك المفضلة هنا', style: TextStyle(color: Colors.grey, fontFamily: 'Changa')),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final item = _favorites[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdDetailScreen(ad: null))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa'), maxLines: 1),
                              const SizedBox(height: 4),
                              Text(item['price'], style: const TextStyle(color: AppTheme.goldColor, fontFamily: 'Changa')),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                  const SizedBox(width: 2),
                                  Text(item['location'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {},
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
