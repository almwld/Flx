import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'نشط', 'منتهي'];

  final List<Map<String, dynamic>> _myAds = [
    {'id': '1', 'title': 'آيفون 15 برو ماكس', 'price': '450,000 ر.ي', 'views': 120, 'status': 'نشط', 'image': 'https://picsum.photos/200/200?1', 'date': '15/03/2026'},
    {'id': '2', 'title': 'سيارة تويوتا كامري', 'price': '8,500,000 ر.ي', 'views': 85, 'status': 'نشط', 'image': 'https://picsum.photos/200/200?2', 'date': '10/03/2026'},
    {'id': '3', 'title': 'شقة في حدة', 'price': '35,000,000 ر.ي', 'views': 200, 'status': 'منتهي', 'image': 'https://picsum.photos/200/200?3', 'date': '01/02/2026'},
    {'id': '4', 'title': 'ساعة أبل', 'price': '95,000 ر.ي', 'views': 45, 'status': 'نشط', 'image': 'https://picsum.photos/200/200?4', 'date': '05/03/2026'},
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
          // شريط الفلاتر
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
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(ad['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(ad['price'], style: const TextStyle(color: AppTheme.goldColor)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.visibility, size: 14, color: Colors.grey),
                                  const SizedBox(width: 2),
                                  Text('${ad['views']}', style: const TextStyle(fontSize: 12)),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: ad['status'] == 'نشط' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      ad['status'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: ad['status'] == 'نشط' ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
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
