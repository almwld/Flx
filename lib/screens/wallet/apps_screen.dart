import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  final List<Map<String, dynamic>> _apps = const [
    {'name': 'NordVPN', 'icon': Icons.vpn_lock, 'color': Colors.blue},
    {'name': 'McAfee', 'icon': Icons.security, 'color': Colors.red},
    {'name': 'كاسبر', 'icon': Icons.shield, 'color': Colors.green},
    {'name': 'ويندوز', 'icon': Icons.window, 'color': Colors.amber},
    {'name': 'أوفيس', 'icon': Icons.description, 'color': Colors.purple},
    {'name': 'IDM', 'icon': Icons.download, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'التطبيقات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          final app = _apps[index];
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (app['color'] as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(app['icon'] as IconData, color: app['color'], size: 30),
              ),
              const SizedBox(height: 8),
              Text(app['name'], style: const TextStyle(fontFamily: 'Changa', fontSize: 12), textAlign: TextAlign.center),
            ],
          );
        },
      ),
    );
  }
}
