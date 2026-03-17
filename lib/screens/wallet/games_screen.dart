import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<String> _games = const [
    'بيجي', 'فري فاير', 'بوبجي', 'فورتنايت', 'كول أوف ديوتي', 'ماينكرافت', 'جينشين', 'ريد ديد'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الألعاب'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.sports_esports, color: AppTheme.goldColor, size: 30),
              ),
              const SizedBox(height: 8),
              Text(_games[index], style: const TextStyle(fontFamily: 'Changa', fontSize: 12), textAlign: TextAlign.center),
            ],
          );
        },
      ),
    );
  }
}
