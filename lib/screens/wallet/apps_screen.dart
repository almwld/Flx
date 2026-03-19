import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  final List<Map<String, dynamic>> _apps = const [
    {'name': 'NordVPN', 'price': '50,000', 'icon': Icons.vpn_lock},
    {'name': 'McAfee', 'price': '45,000', 'icon': Icons.security},
    {'name': 'كاسبر', 'price': '55,000', 'icon': Icons.shield},
    {'name': 'ويندوز', 'price': '120,000', 'icon': Icons.window},
    {'name': 'أوفيس', 'price': '80,000', 'icon': Icons.description},
    {'name': 'IDM', 'price': '15,000', 'icon': Icons.download},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'التطبيقات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _apps.length,
        itemBuilder: (ctx, i) {
          final app = _apps[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(app['icon'] as IconData, color: AppTheme.goldColor),
              ),
              title: Text(app['name']),
              subtitle: Text('السعر: ${app['price']} ر.ي'),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                ),
                child: const Text('شراء'),
              ),
            ),
          );
        },
      ),
    );
  }
}
