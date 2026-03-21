import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});
  @override State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  final List<Map<String, dynamic>> _tickets = [
    {'id': 'T123', 'subject': 'مشكلة في الدفع', 'status': 'مفتوح', 'date': '2026-03-15'},
    {'id': 'T124', 'subject': 'استفسار عن منتج', 'status': 'مغلق', 'date': '2026-03-10'},
  ];
  bool _showNewTicket = false;
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => _showNewTicket = !_showNewTicket),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showNewTicket)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CustomTextField(controller: _subjectController, label: 'الموضوع'),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _messageController, label: 'الرسالة', maxLines: 3),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'إرسال',
                          onPressed: () {
                            setState(() {
                              _showNewTicket = false;
                              _subjectController.clear();
                              _messageController.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم إرسال تذكرتك بنجاح')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'إلغاء',
                          onPressed: () => setState(() => _showNewTicket = false),
                          isOutlined: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tickets.length,
              itemBuilder: (_, i) {
                final t = _tickets[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (t['status'] == 'مفتوح' ? Colors.orange : Colors.green).withOpacity(0.2),
                      child: Icon(Icons.confirmation_number, color: t['status'] == 'مفتوح' ? Colors.orange : Colors.green),
                    ),
                    title: Text(t['subject']),
                    subtitle: Text('رقم: ${t['id']} • ${t['date']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (t['status'] == 'مفتوح' ? Colors.orange : Colors.green).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        t['status'],
                        style: TextStyle(color: t['status'] == 'مفتوح' ? Colors.orange : Colors.green),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
