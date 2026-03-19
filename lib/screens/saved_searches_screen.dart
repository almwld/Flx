import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class SavedSearchesScreen extends StatelessWidget {
  const SavedSearchesScreen({super.key});

  final List<Map<String, dynamic>> _saved = const [
    {'query': 'آيفون للبيع', 'filters': 'صنعاء • السعر: 200k-500k', 'date': 'منذ يومين'},
    {'query': 'سيارة مستعملة', 'filters': 'عدن • موديل 2020+', 'date': 'منذ 5 أيام'},
    {'query': 'شقة للإيجار', 'filters': 'تعز • غرفتين', 'date': 'منذ أسبوع'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'عمليات البحث المحفوظة'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _saved.length,
        itemBuilder: (ctx, i) {
          final s = _saved[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.search, color: AppTheme.goldColor),
              title: Text(s['query']),
              subtitle: Text('${s['filters']} • ${s['date']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
