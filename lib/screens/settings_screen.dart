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
        itemBuilder: (_, i) {
          final item = _settings[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(item['icon'], color: item['color']),
              title: Text(item['title']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item['title']} - قيد التطوير')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
