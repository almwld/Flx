import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'نتفلكس', 'price': '15,000', 'icon': Icons.movie},
    {'name': 'شاهد', 'price': '10,000', 'icon': Icons.tv},
    {'name': 'يوتيوب', 'price': '8,000', 'icon': Icons.video_library},
    {'name': 'سبوتيفاي', 'price': '5,000', 'icon': Icons.music_note},
    {'name': 'أنغامي', 'price': '4,000', 'icon': Icons.audiotrack},
    {'name': 'شاهد VIP', 'price': '12,000', 'icon': Icons.star},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'خدمات ترفيه'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (ctx, i) {
          final s = _services[i];
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
                child: Icon(s['icon'] as IconData, color: AppTheme.goldColor),
              ),
              title: Text(s['name']),
              subtitle: Text('اشتراك: ${s['price']} ر.ي /شهر'),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                ),
                child: const Text('اشترك'),
              ),
            ),
          );
        },
      ),
    );
  }
}
