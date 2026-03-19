import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class EntertainmentServicesScreen extends StatelessWidget {
  const EntertainmentServicesScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'نتفلكس', 'icon': Icons.movie, 'price': '15$'},
    {'name': 'شاهد', 'icon': Icons.tv, 'price': '10$'},
    {'name': 'يوتيوب بريميوم', 'icon': Icons.play_circle, 'price': '12$'},
    {'name': 'سبوتيفاي', 'icon': Icons.music_note, 'price': '8$'},
    {'name': 'أنغامي', 'icon': Icons.audiotrack, 'price': '5$'},
    {'name': 'ديزني بلس', 'icon': Icons.movie, 'price': '14$'},
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
            margin: const EdgeInsets.only(bottom: 8),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(s['icon'] as IconData, color: AppTheme.goldColor),
              title: Text(s['name']),
              subtitle: Text('اشتراك شهري: ${s['price']}'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('اشتراك'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
