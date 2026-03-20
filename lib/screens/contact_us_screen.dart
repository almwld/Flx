import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'تواصل معنا'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: AppTheme.goldColor),
                      title: const Text('البريد الإلكتروني'),
                      subtitle: const Text('support@flexyemen.com'),
                      onTap: () => launchUrl(Uri.parse('mailto:support@flexyemen.com')),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: AppTheme.goldColor),
                      title: const Text('رقم الهاتف'),
                      subtitle: const Text('+967 123 456 789'),
                      onTap: () => launchUrl(Uri.parse('tel:+967123456789')),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: AppTheme.goldColor),
                      title: const Text('العنوان'),
                      subtitle: const Text('صنعاء، اليمن'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('أو تواصل معنا عبر وسائل التواصل الاجتماعي:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, size: 40),
                  onPressed: () => launchUrl(Uri.parse('https://facebook.com/flexyemen')),
                  color: Colors.blue,
                ),
                IconButton(
                  icon: const Icon(Icons.message, size: 40),
                  onPressed: () => launchUrl(Uri.parse('https://wa.me/967123456789')),
                  color: Colors.green,
                ),
                IconButton(
                  icon: const Icon(Icons.telegram, size: 40),
                  onPressed: () => launchUrl(Uri.parse('https://t.me/flexyemen')),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
