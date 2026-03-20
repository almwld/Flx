import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});
  @override State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _all = true;
  bool _orders = true;
  bool _promos = false;
  bool _messages = true;
  bool _email = false;

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
                  value: _all,
                  onChanged: (v) {
                    setState(() {
                      _all = v;
                      _orders = v;
                      _promos = v;
                      _messages = v;
                    });
                  },
                  secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('تحديثات الطلبات'),
                  value: _orders,
                  onChanged: (v) => setState(() => _orders = v),
                  secondary: const Icon(Icons.shopping_bag, color: AppTheme.goldColor),
                ),
                SwitchListTile(
                  title: const Text('العروض والتخفيضات'),
                  value: _promos,
                  onChanged: (v) => setState(() => _promos = v),
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
              value: _email,
              onChanged: (v) => setState(() => _email = v),
              secondary: const Icon(Icons.email, color: AppTheme.goldColor),
            ),
          ),
        ],
      ),
    );
  }
}
