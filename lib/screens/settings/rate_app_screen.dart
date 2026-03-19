import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('تقييم التطبيق', style: TextStyle(fontFamily: 'Changa'))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 100, color: AppTheme.goldColor),
            const SizedBox(height: 20),
            const Text(
              'إذا أعجبك التطبيق، لا تنسى تقييمنا بدعمك',
              style: TextStyle(fontSize: 18, fontFamily: 'Changa'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              children: List.generate(5, (i) => Expanded(
                child: IconButton(
                  icon: Icon(Icons.star, size: 40, color: AppTheme.goldColor),
                  onPressed: () {
                    // هنا يمكن فتح رابط متجر التطبيقات
                    // launchUrl(Uri.parse('market://details?id=com.flexyemen.app'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('شكراً لتقييمك!'))
                    );
                  },
                ),
              )),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse('market://details?id=com.flexyemen.app'));
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('فتح في المتجر'),
            ),
          ],
        ),
      ),
    );
  }
}
