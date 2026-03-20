import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

// قائمة صور وهمية من Picsum (صور حقيقية)
final List<String> imageUrls = [
  'https://picsum.photos/id/1/400/400',  // آيفون
  'https://picsum.photos/id/2/400/400',
  'https://picsum.photos/id/3/400/400',  // سامسونج
  'https://picsum.photos/id/4/400/400',
  'https://picsum.photos/id/5/400/400',  // ماك بوك
  'https://picsum.photos/id/6/400/400',  // آيباد
  'https://picsum.photos/id/7/400/400',  // ساعة
  'https://picsum.photos/id/8/400/400',  // سماعات
  'https://picsum.photos/id/9/400/400',  // كامري
  'https://picsum.photos/id/10/400/400', // النترا
  'https://picsum.photos/id/11/400/400', // شاص
  'https://picsum.photos/id/12/400/400', // شقة
  'https://picsum.photos/id/13/400/400',
  'https://picsum.photos/id/14/400/400', // فيلا
  'https://picsum.photos/id/15/400/400', // غرفة نوم
  'https://picsum.photos/id/16/400/400', // مجلس
  'https://picsum.photos/id/17/400/400', // ثوب
  'https://picsum.photos/id/18/400/400', // عباية
  'https://picsum.photos/id/19/400/400', // مندي
  'https://picsum.photos/id/20/400/400', // زربيان
  'https://picsum.photos/id/21/400/400', // صيانة
  'https://picsum.photos/id/22/400/400', // تنظيف
  'https://picsum.photos/id/23/400/400', // بلاي ستيشن
];

void main() async {
  await Supabase.initialize(
    url: 'https://ziqpohdxtemsmunnhlkm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppcXBvaGR4dGVtc211bm5obGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE3ODQzNDcsImV4cCI6MjA4NzM2MDM0N30.ABAg5YZSrrAtBTWATJ3eRTmo4BuZVyVlrMV1HZjRWs0',
  );

  print('جاري رفع الصور إلى Supabase Storage...');
  
  for (int i = 0; i < imageUrls.length; i++) {
    try {
      final url = imageUrls[i];
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final fileName = 'product_${i + 1}.jpg';
        final file = File('temp_$fileName');
        await file.writeAsBytes(response.bodyBytes);
        
        await Supabase.instance.client.storage.from('products').upload(
          fileName,
          file,
          fileOptions: const FileOptions(cacheControl: '3600'),
        );
        
        final publicUrl = Supabase.instance.client.storage.from('products').getPublicUrl(fileName);
        print('✅ رفعت الصورة $fileName: $publicUrl');
        
        await file.delete();
      }
    } catch (e) {
      print('❌ خطأ في رفع الصورة $i: $e');
    }
  }
  
  print('🎉 تم الانتهاء من رفع جميع الصور!');
}
