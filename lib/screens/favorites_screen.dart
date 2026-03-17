import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/ad_model.dart';
import '../widgets/ad_card.dart';
import 'ad_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<AdModel> _favorites = [
    AdModel(
      id: '1',
      title: 'آيفون 15 برو ماكس',
      description: 'جديد بالكامل مع الضمان',
      price: 450000,
      currency: 'YER',
      images: ['https://via.placeholder.com/300x200'],
      category: 'إلكترونيات',
      subCategory: 'هواتف',
      city: 'صنعاء',
      sellerId: 's1',
      sellerName: 'متجر التقنية',
      sellerRating: 4.8,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('لا توجد عناصر في المفضلة', style: TextStyle(fontFamily: 'Changa', fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                return AdCard(
                  ad: _favorites[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AdDetailScreen(ad: _favorites[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
