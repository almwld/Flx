import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تواصل معنا'),
      body: Padding(padding: const EdgeInsets.all(16), child: Card(child: Padding(padding: const EdgeInsets.all(16),
        child: Column(children: [
          ListTile(leading: const Icon(Icons.email, color: AppTheme.goldColor), title: const Text('البريد الإلكتروني'), subtitle: const Text('support@flexyemen.com'),
            onTap: () => launchUrl(Uri.parse('mailto:support@flexyemen.com'))),
          const Divider(),
          ListTile(leading: const Icon(Icons.phone, color: AppTheme.goldColor), title: const Text('رقم الهاتف'), subtitle: const Text('+967 123 456 789'),
            onTap: () => launchUrl(Uri.parse('tel:+967123456789'))),
          const Divider(),
          ListTile(leading: const Icon(Icons.location_on, color: AppTheme.goldColor), title: const Text('العنوان'), subtitle: const Text('صنعاء، اليمن')),
        ])))),
    );
  }
}
