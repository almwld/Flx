import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/ad_model.dart';
import '../widgets/ad_card.dart';
import 'ad_detail_screen.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'نشط', 'منتهي', 'محجوز'];

  final List<AdModel> _myAds = [
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
      sellerName: 'متجري',
      sellerRating: 4.8,
      createdAt: DateTime.now(),
      views: 120,
      status: 'active',
    ),
    AdModel(
      id: '2',
      title: 'لابتوب ديل',
      description: 'مستعمل بحالة جيدة',
      price: 200000,
      currency: 'YER',
      images: ['https://via.placeholder.com/300x200'],
      category: 'إلكترونيات',
      subCategory: 'لابتوب',
      city: 'صنعاء',
      sellerId: 's1',
      sellerName: 'متجري',
      sellerRating: 4.8,
      createdAt: DateTime.now(),
      views: 45,
      status: 'sold',
    ),
  ];

  List<AdModel> get _filteredAds {
    if (_selectedFilter == 'الكل') return _myAds;
    return _myAds.where((ad) {
      if (_selectedFilter == 'نشط') return ad.status == 'active';
      if (_selectedFilter == 'منتهي') return ad.status == 'sold' || ad.status == 'expired';
      if (_selectedFilter == 'محجوز') return ad.status == 'reserved';
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعلاناتي'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.black : (isDark ? Colors.white : Colors.black87),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _filteredAds.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('لا توجد إعلانات', style: TextStyle(fontFamily: 'Changa', fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredAds.length,
                    itemBuilder: (context, index) {
                      return AdCard(
                        ad: _filteredAds[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AdDetailScreen(ad: _filteredAds[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
