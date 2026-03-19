import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../services/map_service.dart';
import '../services/supabase_service.dart';
import '../models/product_model.dart';
import 'product_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<ProductModel> _nearbyProducts = [];
  bool _isLoading = true;
  String? _error;
  Position? _currentPosition;
  String? _currentAddress;
  bool _locationPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _locationPermissionDenied = false;
    });

    try {
      // التحقق من تفعيل خدمة الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = 'خدمة الموقع غير مفعلة';
          _isLoading = false;
        });
        return;
      }

      // التحقق من الصلاحيات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationPermissionDenied = true;
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationPermissionDenied = true;
          _isLoading = false;
        });
        return;
      }

      // الحصول على الموقع الحالي
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      // محاكاة منتجات قريبة مؤقتاً
      _loadMockProducts();

    } catch (e) {
      setState(() {
        _error = 'حدث خطأ: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMockProducts() async {
    // مؤقتاً نستخدم منتجات وهمية
    try {
      final products = await SupabaseService.getLatestProducts(limit: 10);
      setState(() {
        _nearbyProducts = products;
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  void _openInMaps() {
    if (_currentPosition != null) {
      final url = 'https://www.openstreetmap.org/?mlat=${_currentPosition!.latitude}&mlon=${_currentPosition!.longitude}#map=15/${_currentPosition!.latitude}/${_currentPosition!.longitude}';
      launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الخريطة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _locationPermissionDenied
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_off, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('صلاحية الموقع مطلوبة'),
                      const SizedBox(height: 8),
                      const Text('يرجى السماح بالوصول إلى موقعك'),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'فتح الإعدادات',
                        onPressed: () {
                          Geolocator.openAppSettings();
                        },
                      ),
                    ],
                  ),
                )
              : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(_error!),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'إعادة المحاولة',
                            onPressed: _getCurrentLocation,
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        // خريطة وهمية
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: isDark ? Colors.grey[900] : Colors.grey[200],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.map, size: 100, color: isDark ? Colors.grey[700] : Colors.grey[400]),
                                const SizedBox(height: 16),
                                const Text(
                                  'موقعك الحالي',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                if (_currentPosition != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                CustomButton(
                                  text: 'فتح في OpenStreetMap',
                                  onPressed: _openInMaps,
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // قائمة المنتجات القريبة
                        if (_nearbyProducts.isNotEmpty)
                          Positioned(
                            bottom: 20,
                            left: 16,
                            right: 16,
                            child: Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'قريبة منك',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _nearbyProducts.length,
                                      itemBuilder: (_, i) {
                                        final p = _nearbyProducts[i];
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
                                            width: 120,
                                            margin: const EdgeInsets.only(right: 12),
                                            decoration: BoxDecoration(
                                              color: isDark ? AppTheme.darkSurface : Colors.grey[100],
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.vertical(
                                                      top: Radius.circular(12),
                                                    ),
                                                    child: Image.network(
                                                      p.images.isNotEmpty ? p.images.first : '',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder: (_, __, ___) => Container(
                                                        color: Colors.grey[300],
                                                        child: const Icon(Icons.image),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    p.title,
                                                    style: const TextStyle(fontSize: 11),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
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
                          ),
                      ],
                    ),
    );
  }
}
