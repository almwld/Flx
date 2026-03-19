import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ziqpohdxtemsmunnhlkm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
  );

  await Supabase.instance.client
      .from('notifications')
      .insert({
        'title': '🎉 كل عام وأنتم بخير',
        'body': 'بمناسبة عيد الفطر المبارك، نقدم لكم خصومات تصل إلى 50% على جميع المنتجات',
        'data': {
          'type': 'eid_promotion',
          'image': 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=400',
          'action': 'open_promotions',
        },
        'type': 'broadcast',
        'created_at': DateTime.now().toIso8601String(),
      });

  print('✅ تم إرسال إشعار العيد لجميع المستخدمين');
}
