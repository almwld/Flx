import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'ad_detail_screen.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'نشط', 'منتهي'];

  final List<Map<String, dynamic>> _myAds = [
    {'id': '1', 'title': 'آيفون 15 برو ماكس', 'price': '450,000 ر.ي', 'views': 120, 'status': 'نشط', 'image': 'https://via.placeholder.com/100', 'date': '15/03/2026'},
    {'id': '2', 'title': 'سيارة تويوتا كامري', 'price': '8,500,000 ر.ي', 'views': 85, 'status': 'نشط', 'image': 'https://via.placeholder.com/100', 'date': '10/03/2026'},
    {'id': '3', 'title': 'شقة في حدة', 'price': '35,000,000 ر.ي', 'views': 200, 'status': 'منتهي', 'image': 'https://via.placeholder.com/100', 'date': '01/02/2026'},
  ];

  List<Map<String, dynamic>> get _filteredAds {
    if (_selectedFilter == 'الكل') return _myAds;
    return _myAds.where((ad) => ad['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'إعلاناتي'),
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
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.black : (isDark ? Colors.white : Colors.black87),
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAds.length,
              itemBuilder: (context, index) {
                final ad = _filteredAds[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdDetailScreen(ad: null))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: ad['status'] == 'نشط' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      ad['status'],
                                      style: TextStyle(
                                        color: ad['status'] == 'نشط' ? Colors.green : Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(ad['price'], style: const TextStyle(color: AppTheme.goldColor)),
                                  const Spacer(),
                                  const Icon(Icons.visibility, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('${ad['views']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
