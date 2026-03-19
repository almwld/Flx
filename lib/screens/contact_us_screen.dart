import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تواصل معنا', style: TextStyle(fontFamily: 'Changa'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
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
            const Text('أو تواصل معنا عبر وسائل التواصل الاجتماعي:', style: TextStyle(fontFamily: 'Changa')),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: const Icon(Icons.facebook, size: 40), onPressed: () {}),
                IconButton(icon: const Icon(Icons.message, size: 40), onPressed: () {}),
                IconButton(icon: const Icon(Icons.telegram, size: 40), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
