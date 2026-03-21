import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _cards = const [
    {'currency': 'YER', 'balance': 125000, 'symbol': 'ر.ي', 'name': 'الريال اليمني', 'flag': '🇾🇪'},
    {'currency': 'SAR', 'balance': 5000, 'symbol': 'ر.س', 'name': 'الريال السعودي', 'flag': '🇸🇦'},
    {'currency': 'USD', 'balance': 200, 'symbol': '\$', 'name': 'دولار أمريكي', 'flag': '🇺🇸'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'المحفظة'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            child: ListTile(
              leading: Text(card['flag'] as String, style: const TextStyle(fontSize: 30)),
              title: Text(card['name'] as String),
              subtitle: Text('${card['balance']} ${card['symbol']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
