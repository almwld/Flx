import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'مشاركة التطبيق'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.share, size: 100, color: AppTheme.goldColor),
            const SizedBox(height: 20),
            const Text(
              'شارك التطبيق مع أصدقائك',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('فيسبوك'),
              trailing: const Icon(Icons.share),
              onTap: () => Share.share('حمّل تطبيق Flex Yemen من الرابط: https://play.google.com/store/apps/details?id=com.flexyemen.app'),
            ),
            ListTile(
              leading: const Icon(Icons.whatsapp, color: Colors.green),
              title: const Text('واتساب'),
              trailing: const Icon(Icons.share),
              onTap: () => Share.share('حمّل تطبيق Flex Yemen من الرابط: https://play.google.com/store/apps/details?id=com.flexyemen.app'),
            ),
            ListTile(
              leading: const Icon(Icons.telegram, color: Colors.blue),
              title: const Text('تليجرام'),
              trailing: const Icon(Icons.share),
              onTap: () => Share.share('حمّل تطبيق Flex Yemen من الرابط: https://play.google.com/store/apps/details?id=com.flexyemen.app'),
            ),
          ],
        ),
      ),
    );
  }
}
