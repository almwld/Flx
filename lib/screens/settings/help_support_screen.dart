import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, String>> _faqs = [
    {'q': 'كيف يمكنني إنشاء حساب جديد؟', 'a': 'من شاشة تسجيل الدخول اضغط على "إنشاء حساب جديد".'},
    {'q': 'كيف أضيف إعلاناً؟', 'a': 'من الشريط السفلي اضغط على أيقونة +.'},
    {'q': 'كيف أتواصل مع البائع؟', 'a': 'من صفحة الإعلان اضغط على "محادثة".'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المساعدة والدعم'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('طرق التواصل'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildContactCard(Icons.chat, 'دردشة', Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _buildContactCard(Icons.phone, 'اتصال', Colors.blue)),
                const SizedBox(width: 12),
                Expanded(child: _buildContactCard(Icons.email, 'بريد', Colors.orange)),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('الأسئلة الشائعة'),
            const SizedBox(height: 16),
            ..._faqs.map((faq) => _buildFaqItem(faq['q']!, faq['a']!)),
            const SizedBox(height: 24),
            _buildSectionTitle('أرسل رسالة'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                    maxLines: 5,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      filled: true,
                      fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'إرسال',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إرسال رسالتك')),
                      );
                      _messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Changa',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.goldColor,
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: 'Changa',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(fontFamily: 'Changa'),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
