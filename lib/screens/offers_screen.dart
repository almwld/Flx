import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  final List<Map<String, dynamic>> offers = const [
    {'title': 'خصم 20% على الإلكترونيات', 'code': 'ELECTRO20', 'expiry': '30 مارس 2026'},
    {'title': 'شحن مجاني للطلبات فوق 200 ريال', 'code': 'FREESHIP', 'expiry': '15 أبريل 2026'},
    {'title': 'وفر 50 ريال على أول عملية شراء', 'code': 'NEW50', 'expiry': '1 مايو 2026'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('العروض والتخفيضات', style: TextStyle(fontFamily: 'Changa'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        itemBuilder: (ctx, i) {
          final o = offers[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(o['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_offer, size: 16, color: AppTheme.goldColor),
                      const SizedBox(width: 4),
                      Text('كود العرض: ${o['code']}', style: const TextStyle(color: AppTheme.goldColor)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('صلاحية حتى: ${o['expiry']}', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
