import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<Map<String, dynamic>> _games = const [
    {'name': 'بيجي', 'price': '25,000', 'icon': Icons.sports_esports},
    {'name': 'فري فاير', 'price': '30,000', 'icon': Icons.games},
    {'name': 'بوبجي', 'price': '35,000', 'icon': Icons.games},
    {'name': 'فورتنايت', 'price': '40,000', 'icon': Icons.sports_esports},
    {'name': 'كول أوف ديوتي', 'price': '45,000', 'icon': Icons.games},
    {'name': 'ماينكرافت', 'price': '20,000', 'icon': Icons.games},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الألعاب'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (ctx, i) {
          final game = _games[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(game['icon'] as IconData, color: AppTheme.goldColor),
              ),
              title: Text(game['name']),
              subtitle: Text('السعر: ${game['price']} ر.ي'),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                ),
                child: const Text('شراء'),
              ),
            ),
          );
        },
      ),
    );
  }
}
