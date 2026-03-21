import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

/// لوحة تحكم البائع
class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'لوحة تحكم البائع'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الإحصائيات
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildStatCard('إجمالي المبيعات', '2,500,000 ر.ي', Icons.attach_money, AppTheme.success),
                _buildStatCard('عدد المشاهدات', '15,234', Icons.visibility, AppTheme.info),
                _buildStatCard('التقييم', '4.8', Icons.star, AppTheme.goldColor),
                _buildStatCard('الإعلانات', '45', Icons.post_add, AppTheme.warning),
              ],
            ),
            const SizedBox(height: 24),
            // المبيعات الأخيرة
            Text(
              'المبيعات الأخيرة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              5,
              (index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_bag, color: AppTheme.goldColor),
                  ),
                  title: Text(
                    'طلب #${1000 + index}',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                  subtitle: Text(
                    '2024-01-${15 - index}',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                  ),
                  trailing: Text(
                    '${(index + 1) * 50000} ر.ي',
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
