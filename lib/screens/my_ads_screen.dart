import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import '../models/product_model.dart';
import 'add_ad_screen.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});
  @override State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  List<ProductModel> _ads = [];
  bool _isLoading = true;
  String _filter = 'الكل';
  final List<String> _filters = ['الكل', 'نشط', 'منتهي'];

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  Future<void> _loadAds() async {
    setState(() => _isLoading = true);
    final user = SupabaseService.currentUser;
    if (user != null) {
      _ads = await SupabaseService.getSellerProducts(user.id);
    }
    setState(() => _isLoading = false);
  }

  List<ProductModel> get _filteredAds {
    if (_filter == 'الكل') return _ads;
    return _ads.where((a) {
      return (_filter == 'نشط' && a.status == 'active') ||
             (_filter == 'منتهي' && a.status != 'active');
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'إعلاناتي',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAdScreen()),
              ).then((_) => _loadAds());
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filters.length,
                    itemBuilder: (_, i) {
                      final f = _filters[i];
                      final isSelected = _filter == f;
                      return GestureDetector(
                        onTap: () => setState(() => _filter = f),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.goldColor
                                : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              f,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : (isDark ? Colors.white : Colors.black87),
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
                              Icon(Icons.campaign, size: 80, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              const Text('لا توجد إعلانات'),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const AddAdScreen()),
                                  ).then((_) => _loadAds());
                                },
                                child: const Text('أضف إعلانك الأول'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredAds.length,
                          itemBuilder: (_, i) {
                            final a = _filteredAds[i];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: a.images.isNotEmpty ? a.images.first : '',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            a.title,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${a.price.toStringAsFixed(0)} ${a.currencySymbol}',
                                            style: const TextStyle(color: AppTheme.goldColor),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.visibility, size: 14, color: Colors.grey),
                                              const SizedBox(width: 2),
                                              Text('${a.views}', style: const TextStyle(fontSize: 12)),
                                              const SizedBox(width: 12),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: a.status == 'active'
                                                      ? Colors.green.withOpacity(0.2)
                                                      : Colors.red.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  a.status == 'active' ? 'نشط' : 'منتهي',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: a.status == 'active' ? Colors.green : Colors.red,
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
