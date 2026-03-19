import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import 'products_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [];
  bool _isLoading = false;

  final List<Map<String, dynamic>> _popularCategories = const [
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.brown},
    {'name': 'ملابس', 'icon': Icons.checkroom, 'color': Colors.purple},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    // تحميل عمليات البحث الأخيرة من SharedPreferences
    // مؤقتاً نستخدم بيانات وهمية
    setState(() {
      _recentSearches.addAll(['آيفون', 'سامسونج', 'شقة', 'سيارة']);
    });
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    
    // حفظ البحث في القائمة الأخيرة
    setState(() {
      if (!_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      }
    });

    // الانتقال إلى صفحة النتائج
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductsScreen(searchQuery: query),
      ),
    );
  }

  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        elevation: 0,
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: _searchController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'ابحث عن منتج...',
              hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
              prefixIcon: const Icon(Icons.search, color: AppTheme.goldColor),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () => _searchController.clear(),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: _performSearch,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عمليات البحث الأخيرة
            if (_recentSearches.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'عمليات البحث الأخيرة',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: _clearRecentSearches,
                    child: const Text('مسح الكل'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _recentSearches.map((search) {
                  return Chip(
                    label: Text(search),
                    onDeleted: () {
                      setState(() {
                        _recentSearches.remove(search);
                      });
                    },
                    deleteIcon: const Icon(Icons.close, size: 16),
                    backgroundColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            
            // الفئات الشائعة
            const Text(
              'الفئات الشائعة',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
              children: _popularCategories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(category: cat['name']),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (cat['color'] as Color).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(cat['icon'] as IconData, color: cat['color']),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
