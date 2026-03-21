import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/empty_state.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasAds = false; // تغيير لعرض الإعلانات

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعلاناتي'),
      body: hasAds
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.image, color: AppTheme.goldColor),
                  ),
                  title: Text('إعلان ${index + 1}', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
                  subtitle: Text('${(index + 1) * 10000} ر.ي', style: const TextStyle(fontFamily: 'Changa', color: AppTheme.goldColor)),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('تعديل', style: TextStyle(fontFamily: 'Changa'))),
                      const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(fontFamily: 'Changa', color: AppTheme.error))),
                    ],
                  ),
                ),
              ),
            )
          : NoAdsState(onAddAd: () => Navigator.pushNamed(context, '/add_ad')),
    );
  }
}
