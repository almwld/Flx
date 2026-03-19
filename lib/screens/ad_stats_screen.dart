import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AdStatsScreen extends StatelessWidget {
  final String adId;
  const AdStatsScreen({super.key, required this.adId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('إحصائيات الإعلان', style: TextStyle(fontFamily: 'Changa'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('آيفون 14 برو ماكس', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      _buildStatItem(Icons.visibility, 'المشاهدات', '1,250'),
                      _buildStatItem(Icons.phone, 'الاتصالات', '34'),
                      _buildStatItem(Icons.chat, 'المحادثات', '12'),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('السبعة أيام الأخيرة', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: Card(child: Center(child: Text('رسم بياني سيضاف لاحقاً'))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.goldColor, size: 30),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
