import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});
  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}
class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _allNotifications = true;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإشعارات'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SwitchListTile(
              title: const Text('جميع الإشعارات'),
              value: _allNotifications,
              onChanged: (v) => setState(() => _allNotifications = v),
              secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
            ),
          ),
        ],
      ),
    );
  }
}
