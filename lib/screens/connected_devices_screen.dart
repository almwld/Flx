import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class ConnectedDevicesScreen extends StatelessWidget {
  const ConnectedDevicesScreen({super.key});

  final List<Map<String, dynamic>> devices = const [
    {'name': 'iPhone 14', 'location': 'صنعاء', 'lastActive': 'الآن', 'current': true},
    {'name': 'MacBook Pro', 'location': 'صنعاء', 'lastActive': 'منذ ساعتين', 'current': false},
    {'name': 'Samsung Galaxy', 'location': 'عدن', 'lastActive': 'منذ 3 أيام', 'current': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأجهزة المتصلة'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (ctx, i) {
          final d = devices[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                d['name'].contains('iPhone') ? Icons.phone_iphone :
                d['name'].contains('Mac') ? Icons.computer : Icons.phone_android,
                color: AppTheme.goldColor,
              ),
              title: Text(d['name']),
              subtitle: Text('${d['location']} • ${d['lastActive']}'),
              trailing: d['current']
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('الحالي', style: TextStyle(color: Colors.green)),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                    ),
            ),
          );
        },
      ),
    );
  }
}
