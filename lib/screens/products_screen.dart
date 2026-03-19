import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';

class ProductsScreen extends StatefulWidget {
  final String? category;
  final String? searchQuery;
  const ProductsScreen({super.key, this.category, this.searchQuery});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _error;
  
  String _selectedSort = 'الأحدث';
  final List<String> _sortOptions = ['الأحدث', 'السعر: الأقل', 'السعر: الأعلى', 'الأعلى تقييماً'];
  
  RangeValues _priceRange = const RangeValues(0, 1000000);
  bool _showFilters = false;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category;
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final products = await SupabaseService.getProducts(
        category: _selectedCategory,
        searchQuery: widget.searchQuery,
        minPrice: _priceRange.start,
        maxPrice: _priceRange.end,
      );
      
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ في تحميل المنتجات: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshProducts() async {
    await _loadProducts();
  }

  void _sortProducts(String option) {
    setState(() {
      _selectedSort = option;
      switch (option) {
        case 'السعر: الأقل':
          _products.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'السعر: الأعلى':
          _products.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'الأعلى تقييماً':
          _products.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        default:
          _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.searchQuery != null 
            ? 'نتائج البحث: ${widget.searchQuery}'
            : (widget.category ?? 'المنتجات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshProducts,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Column(
          children: [
            // شريط النتائج والترتيب
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_products.length} منتج',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  DropdownButton<String>(
                    value: _selectedSort,
                    items: _sortOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) _sortProducts(value);
                    },
                    underline: Container(),
                    icon: const Icon(Icons.sort),
                  ),
                ],
              ),
            ),
            
            // محتوى المنتجات
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                              const SizedBox(height: 16),
                              Text(_error!, textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              CustomButton(
                                text: 'إعادة المحاولة',
                                onPressed: _refreshProducts,
                              ),
                            ],
                          ),
                        )
                      : _products.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.inventory_2, size: 80, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  Text('لا توجد منتجات', style: TextStyle(color: Colors.grey[600])),
                                  const SizedBox(height: 8),
                                  Text('جرب تصفح أقسام أخرى', style: TextStyle(color: Colors.grey[500])),
                                ],
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: _products.length,
                              itemBuilder: (ctx, i) {
                                final p = _products[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(product: p),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // صورة المنتج
                                        Expanded(
                                          flex: 3,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.vertical(
                                                  top: Radius.circular(12),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: p.images.isNotEmpty 
                                                      ? p.images.first 
                                                      : 'https://via.placeholder.com/300',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  placeholder: (_, __) => Container(
                                                    color: Colors.grey[300],
                                                    child: const Center(
                                                      child: CircularProgressIndicator(strokeWidth: 2),
                                                    ),
                                                  ),
                                                  errorWidget: (_, __, ___) => Container(
                                                    color: Colors.grey[300],
                                                    child: const Icon(Icons.broken_image),
                                                  ),
                                                ),
                                              ),
                                              if (p.discountPercentage != null)
                                                Positioned(
                                                  top: 8,
                                                  left: 8,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Text(
                                                      '${p.discountPercentage}%',
                                                      style: const TextStyle(color: Colors.white, fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              if (!p.inStock)
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: const Text(
                                                      'غير متوفر',
                                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        // تفاصيل المنتج
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  p.title,
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    if (p.oldPrice != null) ...[
                                                      Text(
                                                        '${p.oldPrice!.toStringAsFixed(0)} ر.ي',
                                                        style: const TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                    ],
                                                    Expanded(
                                                      child: Text(
                                                        '${p.price.toStringAsFixed(0)} ر.ي',
                                                        style: const TextStyle(
                                                          color: AppTheme.goldColor,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.star, size: 12, color: Colors.amber),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      p.rating.toStringAsFixed(1),
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      '(${p.reviewCount})',
                                                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('تصفية المنتجات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // نطاق السعر
                const Text('نطاق السعر', style: TextStyle(fontWeight: FontWeight.bold)),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 1000000,
                  divisions: 20,
                  labels: RangeLabels(
                    '${_priceRange.start.round()} ر.ي',
                    '${_priceRange.end.round()} ر.ي',
                  ),
                  onChanged: (v) => setState(() => _priceRange = v),
                ),
                
                const SizedBox(height: 16),
                
                // أزرار
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'تطبيق',
                        onPressed: () {
                          Navigator.pop(context);
                          _loadProducts();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'إلغاء',
                        onPressed: () => Navigator.pop(context),
                        isOutlined: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
