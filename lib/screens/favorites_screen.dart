import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, dynamic>> _favorites = const [
    {'id': '1', 'title': 'آيفون 15 برو ماكس', 'price': '450,000 ر.ي', 'image': 'https://picsum.photos/200/200?1', 'location': 'صنعاء', 'rating': 4.8},
    {'id': '2', 'title': 'سيارة تويوتا كامري', 'price': '8,500,000 ر.ي', 'image': 'https://picsum.photos/200/200?2', 'location': 'عدن', 'rating': 4.5},
    {'id': '3', 'title': 'شقة في حدة', 'price': '35,000,000 ر.ي', 'image': 'https://picsum.photos/200/200?3', 'location': 'صنعاء', 'rating': 4.9},
    {'id': '4', 'title': 'ساعة أبل', 'price': '95,000 ر.ي', 'image': 'https://picsum.photos/200/200?4', 'location': 'تعز', 'rating': 4.7},
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
                  const Text('لا توجد عناصر في المفضلة', style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final item = _favorites[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: item['image'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(item['price'], style: const TextStyle(color: AppTheme.goldColor)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                  const SizedBox(width: 2),
                                  Text(item['location'], style: const TextStyle(fontSize: 11)),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.star, size: 12, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text(item['rating'].toString(), style: const TextStyle(fontSize: 11)),
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
