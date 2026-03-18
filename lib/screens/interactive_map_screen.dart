import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
// لو أردت إضافة خريطة حقيقية، استخدم google_maps_flutter أو mapbox

class InteractiveMapScreen extends StatelessWidget {
  const InteractiveMapScreen({super.key});

  final List<Map<String, dynamic>> _adsOnMap = const [
    {'title': 'آيفون 15', 'lat': 15.3694, 'lng': 44.1910, 'price': '450,000'},
    {'title': 'شقة في حدة', 'lat': 15.3547, 'lng': 44.2067, 'price': '35,000,000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الخريطة التفاعلية'),
      body: Stack(
        children: [
          // خريطة وهمية مؤقتاً
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('سيتم دمج الخريطة قريباً', style: TextStyle(fontFamily: 'Changa')),
                ],
              ),
            ),
          ),
          // قائمة الإعلانات القريبة
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16).animate().slideY(begin: 0.5, end: 0, duration: 600.ms).fadeIn(),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkCard
                    : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('قريبة منك', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 12),
                  ..._adsOnMap.map((ad) => ListTile(
                    leading: const Icon(Icons.location_on, color: AppTheme.goldColor),
                    title: Text(ad['title']),
                    subtitle: Text(ad['price']),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
