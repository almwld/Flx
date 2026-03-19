import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {'title': 'عرض خاص', 'message': 'خصم 20% على جميع الإعلانات', 'time': 'منذ ساعة', 'read': false},
    {'title': 'رسالة جديدة', 'message': 'أحمد محمد أرسل لك رسالة', 'time': 'منذ 3 ساعات', 'read': false},
    {'title': 'تمت الموافقة', 'message': 'تمت الموافقة على إعلانك', 'time': 'منذ يوم', 'read': true},
    {'title': 'تم الشحن', 'message': 'تم شحن طلبك رقم #123', 'time': 'منذ يومين', 'read': true},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'سجل الإشعارات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (ctx, i) {
          final n = _notifications[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(12),
              border: !n['read'] ? Border.all(color: AppTheme.goldColor, width: 1) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.goldColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, color: AppTheme.goldColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title'], style: TextStyle(fontWeight: !n['read'] ? FontWeight.bold : FontWeight.normal)),
                      const SizedBox(height: 4),
                      Text(n['message'], style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Text(n['time'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
