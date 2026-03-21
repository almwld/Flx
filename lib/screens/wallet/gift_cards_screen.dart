import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class GiftCardsScreen extends StatelessWidget {
  const GiftCardsScreen({super.key});
  static const List<String> _cards = ['جوجل بلاي', 'آيتونز', 'ستيم', 'بلاي ستيشن'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'بطاقات هدايا'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cards.length,
        itemBuilder: (_, i) => Card(
          child: ListTile(title: Text(_cards[i]), trailing: const Text('شراء', style: TextStyle(color: Color(0xFFD4AF37)))),
        ),
      ),
    );
  }
}
