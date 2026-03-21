import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../services/supabase_service.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});
  @override State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    // محاكاة جلب المعاملات من Supabase
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _transactions = [
        {'type': 'إيداع', 'amount': '+ 50,000', 'date': '2026-03-20', 'status': 'مكتمل', 'color': Colors.green},
        {'type': 'سحب', 'amount': '- 25,000', 'date': '2026-03-19', 'status': 'مكتمل', 'color': Colors.red},
        {'type': 'تحويل', 'amount': '- 10,000', 'date': '2026-03-18', 'status': 'مكتمل', 'color': Colors.orange},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'العمليات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (_, i) {
                final t = _transactions[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (t['color'] as Color).withOpacity(0.2),
                      child: Icon(t['type'] == 'إيداع' ? Icons.arrow_downward : Icons.arrow_upward, color: t['color']),
                    ),
                    title: Text(t['type']),
                    subtitle: Text(t['date']),
                    trailing: Text(t['amount'], style: TextStyle(color: t['color'], fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
    );
  }
}
