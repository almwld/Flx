import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasNotifications = false;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإشعارات'),
      body: hasNotifications
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: AppTheme.goldColor, child: Icon(Icons.notifications, color: Colors.white)),
                  title: Text('إشعار ${index + 1}', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
                  subtitle: const Text('تفاصيل الإشعار', style: TextStyle(fontFamily: 'Changa')),
                  trailing: Text('منذ ${index + 1} ساعة', style: TextStyle(fontFamily: 'Changa', fontSize: 12, color: AppTheme.getSecondaryTextColor(context))),
                ),
              ),
            )
          : const EmptyState(icon: Icons.notifications_none, title: 'لا توجد إشعارات'),
    );
  }
}
