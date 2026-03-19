import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class NearbyStoresScreen extends StatelessWidget {
  const NearbyStoresScreen({super.key});

  final List<Map<String, dynamic>> _stores = const [
    {'name': 'متجر التقنية', 'distance': '500 م', 'rating': 4.5},
    {'name': 'معرض السيارات', 'distance': '1.2 كم', 'rating': 4.2},
    {'name': 'مكتب العقارات', 'distance': '800 م', 'rating': 4.8},
    {'name': 'مطعم ومقهى', 'distance': '300 م', 'rating': 4.3},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المتاجر القريبة'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _stores.length,
        itemBuilder: (ctx, i) {
          final s = _stores[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.store, color: AppTheme.goldColor),
              title: Text(s['name']),
              subtitle: Text('${s['distance']} • ⭐ ${s['rating']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
