import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    
    try {
      final response = await Supabase.instance.client
          .from('notifications')
          .select()
          .order('created_at', ascending: false)
          .limit(50);
          
      setState(() {
        _notifications = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الإشعارات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('لا توجد إشعارات', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notifications.length,
                  itemBuilder: (ctx, i) {
                    final notif = _notifications[i];
                    final isEid = notif['data']?['type'] == 'eid_promotion';
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: isEid
                            ? const LinearGradient(
                                colors: [AppTheme.goldColor, Color(0xFFFFC107)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        color: isEid ? null : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isEid ? Colors.transparent : AppTheme.goldColor.withOpacity(0.3),
                        ),
                      ),
                      child: ListTile(
                        leading: isEid
                            ? const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.celebration, color: AppTheme.goldColor),
                              )
                            : CircleAvatar(
                                backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                                child: const Icon(Icons.notifications, color: AppTheme.goldColor),
                              ),
                        title: Text(
                          notif['title'] ?? 'إشعار',
                          style: TextStyle(
                            color: isEid ? Colors.white : null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notif['body'] ?? '',
                          style: TextStyle(
                            color: isEid ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                        trailing: Text(
                          _timeAgo(DateTime.parse(notif['created_at'])),
                          style: TextStyle(
                            fontSize: 11,
                            color: isEid ? Colors.white54 : Colors.grey[500],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}
