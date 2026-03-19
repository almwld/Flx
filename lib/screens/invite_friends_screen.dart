import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'دعوة الأصدقاء'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.people, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text(
              'ادعُ أصدقاءك واحصل على مكافآت',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 8),
            const Text(
              'لكل صديق يسجل عبر رابطك، ستحصل على 100 نقطة',
              style: TextStyle(color: Colors.grey, fontFamily: 'Changa'),
            ),
            const SizedBox(height: 30),
            const Text('رابط الدعوة الخاص بك:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://flexyemen.app/r/USER123',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppTheme.goldColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Share.share('انضم إلي على Flex Yemen عبر الرابط: https://flexyemen.app/r/USER123'),
                icon: const Icon(Icons.share),
                label: const Text('مشاركة الرابط'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
