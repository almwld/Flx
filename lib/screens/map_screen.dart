import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  final List<Map<String, dynamic>> _locations = const [
    {'name': 'متجر التقنية', 'address': 'شارع حدة، صنعاء', 'distance': '2.5 كم'},
    {'name': 'معرض السيارات', 'address': 'شارع تعز، صنعاء', 'distance': '3.8 كم'},
    {'name': 'مكتب العقارات', 'address': 'شارع الزبيري، صنعاء', 'distance': '1.2 كم'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الخريطة'),
      body: Stack(
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
                  const Text('قريباً', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 8),
                  const Text('خدمة الخرائط قيد التطوير', style: TextStyle(color: Colors.grey, fontFamily: 'Changa')),
                ],
              ),
            ),
          ),
          // قائمة المواقع
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('قريبة منك', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Changa')),
                  const SizedBox(height: 12),
                  ..._locations.map((loc) => ListTile(
                    leading: const Icon(Icons.location_on, color: AppTheme.goldColor),
                    title: Text(loc['name'], style: const TextStyle(fontFamily: 'Changa')),
                    subtitle: Text('${loc['address']} • ${loc['distance']}', style: const TextStyle(fontSize: 12)),
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
