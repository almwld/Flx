import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final transactions = [
      {'type': 'إيداع', 'amount': '+ 50,000', 'date': '2024-01-15', 'status': 'مكتمل', 'color': AppTheme.success},
      {'type': 'سحب', 'amount': '- 25,000', 'date': '2024-01-14', 'status': 'مكتمل', 'color': AppTheme.error},
      {'type': 'تحويل', 'amount': '- 10,000', 'date': '2024-01-13', 'status': 'مكتمل', 'color': AppTheme.warning},
      {'type': 'دفع فاتورة', 'amount': '- 5,000', 'date': '2024-01-12', 'status': 'مكتمل', 'color': AppTheme.error},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const CustomAppBar(title: 'العمليات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final t = transactions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: (t['color'] as Color).withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.swap_horiz, color: t['color'] as Color)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t['type'] as String, style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.w600, color: isDark ? AppTheme.darkText : AppTheme.lightText)), const SizedBox(height: 4), Text(t['date'] as String, style: TextStyle(fontFamily: 'Changa', fontSize: 12, color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary))])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(t['amount'] as String, style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold, color: t['color'] as Color)), const SizedBox(height: 4), Text(t['status'] as String, style: const TextStyle(fontFamily: 'Changa', fontSize: 12, color: AppTheme.success))]),
            ]),
          );
        },
      ),
    );
  }
}
