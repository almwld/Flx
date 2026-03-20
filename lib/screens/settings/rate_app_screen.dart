import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تقييم التطبيق'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 100, color: AppTheme.goldColor),
            const SizedBox(height: 20),
            const Text(
              'إذا أعجبك التطبيق، لا تنسى تقييمنا بدعمك',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => IconButton(
                icon: Icon(Icons.star, size: 50, color: AppTheme.goldColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('شكراً لتقييمك!')),
                  );
                },
              )),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.flexyemen.app'));
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('فتح في المتجر'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                side: const BorderSide(color: AppTheme.goldColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
