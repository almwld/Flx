import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({super.key});

  final List<String> _services = const [
    'نتفلكس', 'شاهد', 'يوتيوب', 'سبوتيفاي', 'أنغامي', 'شاهد VIP'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'خدمات ترفيه'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _services.length,
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
                child: const Icon(Icons.movie, color: AppTheme.goldColor, size: 30),
              ),
              const SizedBox(height: 8),
              Text(_services[index], style: const TextStyle(fontFamily: 'Changa', fontSize: 12), textAlign: TextAlign.center),
            ],
          );
        },
      ),
    );
  }
}
