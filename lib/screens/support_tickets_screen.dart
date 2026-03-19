import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  final List<Map<String, dynamic>> _tickets = [
    {'id': 'T123', 'subject': 'مشكلة في الدفع', 'status': 'مفتوح', 'date': '2026-03-15'},
    {'id': 'T124', 'subject': 'استفسار عن منتج', 'status': 'مغلق', 'date': '2026-03-10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني', style: TextStyle(fontFamily: 'Changa')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNewTicketDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tickets.length,
        itemBuilder: (ctx, i) {
          final t = _tickets[i];
          return Card(
            child: ListTile(
              title: Text(t['subject']),
              subtitle: Text('رقم التذكرة: ${t['id']} - ${t['date']}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: t['status'] == 'مفتوح' ? Colors.orange.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  t['status'],
                  style: TextStyle(color: t['status'] == 'مفتوح' ? Colors.orange : Colors.green),
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  void _showNewTicketDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تذكرة جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: subjectController, decoration: const InputDecoration(labelText: 'الموضوع')),
            const SizedBox(height: 8),
            TextField(controller: messageController, decoration: const InputDecoration(labelText: 'الرسالة'), maxLines: 3),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              // إرسال التذكرة
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال التذكرة')));
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }
}
