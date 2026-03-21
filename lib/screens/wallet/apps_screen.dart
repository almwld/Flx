import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});
  static const List<String> _apps = ['NordVPN', 'McAfee', 'ويندوز', 'أوفيس'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'التطبيقات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _apps.length,
        itemBuilder: (_, i) => Card(
          child: ListTile(title: Text(_apps[i]), trailing: const Text('شراء', style: TextStyle(color: Color(0xFFD4AF37)))),
        ),
      ),
    );
  }
}
