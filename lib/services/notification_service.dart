import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('❌ لم يتم منح صلاحية الإشعارات');
      return;
    }

    String? token = await _fcm.getToken();
    print('📱 FCM Token: $token');
    
    await _saveTokenToDatabase(token);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpened);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("📱 رسالة في الخلفية: ${message.messageId}");
    _showLocalNotification(message);
  }

  static void _handleMessage(RemoteMessage message) {
    print('📱 رسالة جديدة: ${message.notification?.title}');
    _showLocalNotification(message);
  }

  static void _handleMessageOpened(RemoteMessage message) {
    print('📱 تم فتح التطبيق من الإشعار: ${message.messageId}');
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'eid_channel',
      'إشعارات العيد',
      channelDescription: 'إشعارات المناسبات والعروض',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'تنبيه',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  static Future<void> _saveTokenToDatabase(String? token) async {
    if (token == null) return;
    
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      await Supabase.instance.client
          .from('user_devices')
          .upsert({
            'user_id': user.id,
            'fcm_token': token,
            'updated_at': DateTime.now().toIso8601String(),
          });
    }
  }

  static Future<void> sendNotificationToAll({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    await Supabase.instance.client
        .from('notifications')
        .insert({
          'title': title,
          'body': body,
          'data': data,
          'type': 'broadcast',
          'created_at': DateTime.now().toIso8601String(),
        });
  }

  static Future<void> sendEidNotification() async {
    await sendNotificationToAll(
      title: '🎉 كل عام وأنتم بخير',
      body: 'بمناسبة عيد الفطر المبارك، نقدم لكم خصومات تصل إلى 50% على جميع المنتجات',
      data: {
        'type': 'eid_promotion',
        'image': 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=400',
        'action': 'open_promotions',
      },
    );
  }
}
