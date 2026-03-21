import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});
  final List<String> _games = ['بيجي', 'فري فاير', 'بوبجي', 'فورتنايت'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الألعاب'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (_, i) => Card(
          child: ListTile(title: Text(_games[i]), trailing: const Text('شراء', style: TextStyle(color: Color(0xFFD4AF37)))),
        ),
      ),
    );
  }
}
