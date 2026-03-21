import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  final List<Map<String, dynamic>> transactions = const [
    {'type': 'إيداع', 'amount': '+50,000', 'date': '2024-01-15', 'status': 'مكتمل'},
    {'type': 'سحب', 'amount': '-20,000', 'date': '2024-01-14', 'status': 'مكتمل'},
    {'type': 'تحويل', 'amount': '-15,000', 'date': '2024-01-13', 'status': 'مكتمل'},
    {'type': 'دفع', 'amount': '-5,000', 'date': '2024-01-12', 'status': 'مكتمل'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سجل العمليات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final t = transactions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: t['amount'].toString().startsWith('+') ? AppTheme.success.withOpacity(0.1) : AppTheme.error.withOpacity(0.1),
                child: Icon(
                  t['amount'].toString().startsWith('+') ? Icons.arrow_downward : Icons.arrow_upward,
                  color: t['amount'].toString().startsWith('+') ? AppTheme.success : AppTheme.error,
                ),
              ),
              title: Text(t['type'], style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
              subtitle: Text(t['date'], style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context))),
              trailing: Text(
                t['amount'],
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                  color: t['amount'].toString().startsWith('+') ? AppTheme.success : AppTheme.error,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
