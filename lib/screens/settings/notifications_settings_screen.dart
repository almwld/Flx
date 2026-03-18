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
  bool _orderUpdates = true;
  bool _promotions = false;
  bool _messages = true;
  bool _emailNotifications = false;

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
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('جميع الإشعارات'),
                  subtitle: const Text('تشغيل أو إيقاف الكل'),
                  value: _allNotifications,
                  onChanged: (v) {
                    setState(() {
                      _allNotifications = v;
                      _orderUpdates = v;
                      _promotions = v;
                      _messages = v;
                    });
                  },
                  secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('تحديثات الطلبات'),
                  value: _orderUpdates,
                  onChanged: (v) => setState(() => _orderUpdates = v),
                  secondary: const Icon(Icons.shopping_bag, color: AppTheme.goldColor),
                ),
                SwitchListTile(
                  title: const Text('العروض والتخفيضات'),
                  value: _promotions,
                  onChanged: (v) => setState(() => _promotions = v),
                  secondary: const Icon(Icons.local_offer, color: AppTheme.goldColor),
                ),
                SwitchListTile(
                  title: const Text('الرسائل'),
                  value: _messages,
                  onChanged: (v) => setState(() => _messages = v),
                  secondary: const Icon(Icons.chat, color: AppTheme.goldColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SwitchListTile(
              title: const Text('الإشعارات عبر البريد الإلكتروني'),
              value: _emailNotifications,
              onChanged: (v) => setState(() => _emailNotifications = v),
              secondary: const Icon(Icons.email, color: AppTheme.goldColor),
            ),
          ),
        ],
      ),
    );
  }
}
