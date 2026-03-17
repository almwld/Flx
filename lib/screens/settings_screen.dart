import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final List<Map<String, dynamic>> _settings = const [
    {'title': 'الإشعارات', 'icon': Icons.notifications, 'color': Colors.blue},
    {'title': 'الأمان والخصوصية', 'icon': Icons.security, 'color': Colors.green},
    {'title': 'اللغة', 'icon': Icons.language, 'color': Colors.orange},
    {'title': 'طرق الدفع', 'icon': Icons.payment, 'color': Colors.purple},
    {'title': 'المساعدة والدعم', 'icon': Icons.help, 'color': Colors.teal},
    {'title': 'عن التطبيق', 'icon': Icons.info, 'color': Colors.red},
    {'title': 'سياسة الخصوصية', 'icon': Icons.privacy_tip, 'color': Colors.indigo},
    {'title': 'تقييم التطبيق', 'icon': Icons.star, 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _settings.length,
        itemBuilder: (context, index) {
          final item = _settings[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'] as IconData, color: item['color']),
              ),
              title: Text(item['title'], style: const TextStyle(fontFamily: 'Changa')),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
