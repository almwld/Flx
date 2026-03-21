import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/simple_app_bar.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'دفع الفواتير'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBillCard(context, 'فاتورة الكهرباء', '25,000 ر.ي', Icons.electric_bolt, Colors.yellow),
          _buildBillCard(context, 'فاتورة الماء', '8,500 ر.ي', Icons.water_drop, Colors.blue),
          _buildBillCard(context, 'فاتورة الإنترنت', '15,000 ر.ي', Icons.wifi, Colors.green),
          _buildBillCard(context, 'فاتورة الهاتف', '5,000 ر.ي', Icons.phone, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildBillCard(BuildContext context, String title, String amount, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
        subtitle: Text(amount, style: const TextStyle(fontFamily: 'Changa', color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: AppTheme.darkText),
          child: const Text('دفع', style: TextStyle(fontFamily: 'Changa')),
        ),
      ),
    );
  }
}
