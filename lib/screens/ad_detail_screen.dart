import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';

class AdDetailScreen extends StatelessWidget {
  const AdDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(background: Container(color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image, size: 100, color: AppTheme.goldColor))),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text('عنوان المنتج', style: TextStyle(fontFamily: 'Changa', fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
                const SizedBox(height: 8),
                const Text('500,000 ر.ي', style: TextStyle(fontFamily: 'Changa', fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
                const SizedBox(height: 16),
                Row(children: [const Icon(Icons.location_on, color: AppTheme.goldColor), const SizedBox(width: 8), Text('صنعاء', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context)))]),
                const SizedBox(height: 24),
                Text('الوصف', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.getTextColor(context))),
                const SizedBox(height: 8),
                Text('وصف تفصيلي للمنتج هنا...', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getSecondaryTextColor(context))),
                const SizedBox(height: 24),
                Row(children: [
                  Expanded(child: CustomButton(text: 'محادثة', onPressed: () => Navigator.pushNamed(context, '/chat_detail'))),
                  const SizedBox(width: 12),
                  Expanded(child: CustomButton(text: 'اتصال', onPressed: () {}, isOutlined: true)),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
