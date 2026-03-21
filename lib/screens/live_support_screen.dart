import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class LiveSupportScreen extends StatelessWidget {
  const LiveSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الدعم الفني'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSupportCard(Icons.phone, 'اتصال', '777-123-456', Colors.green),
            _buildSupportCard(Icons.message, 'واتساب', '777-123-456', Colors.green),
            _buildSupportCard(Icons.telegram, 'تليجرام', '@flexyemen', Colors.blue),
            _buildSupportCard(Icons.email, 'بريد', 'support@flexyemen.com', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard(IconData icon, String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontFamily: 'Changa')),
        subtitle: Text(value, style: const TextStyle(fontFamily: 'Changa')),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
