import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  final List<Map<String, dynamic>> _rewards = const [
    {'action': 'دعوة صديق', 'points': 100, 'status': 'مكتمل', 'date': '2026-03-15'},
    {'action': 'أول إعلان', 'points': 50, 'status': 'مكتمل', 'date': '2026-03-10'},
    {'action': 'أول عملية شراء', 'points': 200, 'status': 'معلق', 'date': '-'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المكافآت'),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.goldColor, AppTheme.goldLight],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.card_giftcard, size: 40, color: Colors.black),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('نقاطك الحالية', style: TextStyle(color: Colors.black87, fontFamily: 'Changa')),
                    const SizedBox(height: 4),
                    Text('1,250 نقطة', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Changa')),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('سجل المكافآت', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Changa')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _rewards.length,
              itemBuilder: (ctx, i) {
                final r = _rewards[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: r['status'] == 'مكتمل' ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        r['status'] == 'مكتمل' ? Icons.check : Icons.pending,
                        color: r['status'] == 'مكتمل' ? Colors.green : Colors.orange,
                      ),
                    ),
                    title: Text(r['action']),
                    subtitle: Text('${r['points']} نقطة • ${r['date']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: r['status'] == 'مكتمل' ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        r['status'],
                        style: TextStyle(
                          color: r['status'] == 'مكتمل' ? Colors.green : Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
