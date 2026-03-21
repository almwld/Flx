import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سياسة الخصوصية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('سياسة الخصوصية', style: TextStyle(fontFamily: 'Changa', fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
            const SizedBox(height: 16),
            Text('نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية.', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
            const SizedBox(height: 16),
            Text('1. جمع المعلومات', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
            const SizedBox(height: 8),
            Text('نقوم بجمع المعلومات اللازمة فقط لتقديم خدماتنا بشكل أفضل.', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context))),
            const SizedBox(height: 16),
            Text('2. استخدام المعلومات', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
            const SizedBox(height: 8),
            Text('نستخدم معلوماتك فقط لأغراض تقديم الخدمة وتحسين تجربتك.', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context))),
            const SizedBox(height: 16),
            Text('3. حماية المعلومات', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
            const SizedBox(height: 8),
            Text('نستخدم تقنيات أمان متقدمة لحماية بياناتك.', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context))),
          ],
        ),
      ),
    );
  }
}
