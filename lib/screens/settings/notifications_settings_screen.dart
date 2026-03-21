import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _allNotifications = true;
  bool _orderNotifications = true;
  bool _messageNotifications = true;
  bool _offerNotifications = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات الإشعارات'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('جميع الإشعارات', style: TextStyle(fontFamily: 'Changa')),
            value: _allNotifications,
            activeColor: AppTheme.goldColor,
            onChanged: (value) => setState(() => _allNotifications = value),
          ),
          SwitchListTile(
            title: const Text('إشعارات الطلبات', style: TextStyle(fontFamily: 'Changa')),
            value: _orderNotifications,
            activeColor: AppTheme.goldColor,
            onChanged: (value) => setState(() => _orderNotifications = value),
          ),
          SwitchListTile(
            title: const Text('إشعارات الرسائل', style: TextStyle(fontFamily: 'Changa')),
            value: _messageNotifications,
            activeColor: AppTheme.goldColor,
            onChanged: (value) => setState(() => _messageNotifications = value),
          ),
          SwitchListTile(
            title: const Text('إشعارات العروض', style: TextStyle(fontFamily: 'Changa')),
            value: _offerNotifications,
            activeColor: AppTheme.goldColor,
            onChanged: (value) => setState(() => _offerNotifications = value),
          ),
        ],
      ),
    );
  }
}
