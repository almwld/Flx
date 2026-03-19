import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ManageAdsScreen extends StatefulWidget {
  const ManageAdsScreen({super.key});

  @override
  State<ManageAdsScreen> createState() => _ManageAdsScreenState();
}

class _ManageAdsScreenState extends State<ManageAdsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _ads = [
    {'title': 'آيفون 14 برو ماكس', 'price': '450,000', 'status': 'active', 'views': 120, 'calls': 5},
    {'title': 'سامسونج S24 الترا', 'price': '380,000', 'status': 'active', 'views': 80, 'calls': 2},
    {'title': 'لابتوب لينوفو', 'price': '320,000', 'status': 'pending', 'views': 0, 'calls': 0},
    {'title': 'ماك بوك برو', 'price': '1,200,000', 'status': 'expired', 'views': 300, 'calls': 10},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الإعلانات', style: TextStyle(fontFamily: 'Changa')),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'نشطة'),
            Tab(text: 'قيد المراجعة'),
            Tab(text: 'منتهية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_ads.where((a) => a['status'] == 'active').toList(), isDark),
          _buildList(_ads.where((a) => a['status'] == 'pending').toList(), isDark),
          _buildList(_ads.where((a) => a['status'] == 'expired').toList(), isDark),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> ads, bool isDark) {
    if (ads.isEmpty) {
      return Center(child: Text('لا توجد إعلانات', style: TextStyle(color: Colors.grey[600])));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: ads.length,
      itemBuilder: (ctx, i) {
        final ad = ads[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(ad['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ad['status'] == 'active' ? Colors.green.withOpacity(0.2) : (ad['status'] == 'pending' ? Colors.orange.withOpacity(0.2) : Colors.red.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ad['status'] == 'active' ? 'نشط' : (ad['status'] == 'pending' ? 'قيد المراجعة' : 'منتهي'),
                        style: TextStyle(fontSize: 12, color: ad['status'] == 'active' ? Colors.green : (ad['status'] == 'pending' ? Colors.orange : Colors.red)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('السعر: ${ad['price']} ر.ي', style: const TextStyle(color: AppTheme.goldColor)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 16, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text('${ad['views']}', style: TextStyle(color: Colors.grey[500])),
                    const SizedBox(width: 16),
                    Icon(Icons.phone, size: 16, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text('${ad['calls']}', style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('تعديل'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.bar_chart, size: 18),
                      label: const Text('الإحصائيات'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                      label: const Text('حذف', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
