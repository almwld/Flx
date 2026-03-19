import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  // خدمة إشعارات مبسطة تعتمد فقط على قاعدة البيانات
  static Future<void> initialize() async {
    print("✅ نظام الإشعارات الداخلي مفعل");
  }

  // إرسال إشعار لجميع المستخدمين (يتم حفظه في قاعدة البيانات فقط)
  static Future<void> sendNotificationToAll({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      await Supabase.instance.client
          .from('notifications')
          .insert({
            'title': title,
            'body': body,
            'data': data,
            'type': 'broadcast',
            'created_at': DateTime.now().toIso8601String(),
          });
      print("✅ تم حفظ الإشعار في قاعدة البيانات");
    } catch (e) {
      print("❌ فشل حفظ الإشعار: $e");
    }
  }

  // إرسال إشعار العيد
  static Future<void> sendEidNotification() async {
    await sendNotificationToAll(
      title: '🎉 كل عام وأنتم بخير',
      body: 'بمناسبة عيد الفطر المبارك، نقدم لكم خصومات تصل إلى 50%',
      data: {'type': 'eid_promotion'},
    );
  }
}
