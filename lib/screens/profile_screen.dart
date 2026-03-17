import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'my_orders_screen.dart';
import 'settings_screen.dart';
import 'account_info_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isGuest;
  const ProfileScreen({super.key, this.isGuest = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'إعلاناتي', 'icon': Icons.campaign, 'color': Colors.blue, 'screen': const MyAdsScreen()},
    {'title': 'المفضلة', 'icon': Icons.favorite, 'color': Colors.red, 'screen': const FavoritesScreen()},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag, 'color': Colors.green, 'screen': const MyOrdersScreen()},
    {'title': 'معلومات الحساب', 'icon': Icons.person, 'color': Colors.orange, 'screen': const AccountInfoScreen()},
    {'title': 'الإعدادات', 'icon': Icons.settings, 'color': Colors.purple, 'screen': const SettingsScreen()},
    {'title': 'المساعدة والدعم', 'icon': Icons.help_outline, 'color': Colors.teal, 'screen': null},
    {'title': 'عن التطبيق', 'icon': Icons.info_outline, 'color': Colors.cyan, 'screen': null},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'حسابي'),
      body: CustomScrollView(
        slivers: [
          if (!widget.isGuest)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.goldColor, AppTheme.goldLight],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 40, color: Colors.black),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'محمد أحمد',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                          ),
                          const Text(
                            'mohammed@email.com',
                            style: TextStyle(color: Colors.grey, fontFamily: 'Changa'),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildStatItem('4.8', 'التقييم'),
                              const SizedBox(width: 16),
                              _buildStatItem('156', 'المتابعين'),
                              const SizedBox(width: 16),
                              _buildStatItem('12', 'الإعلانات'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.isGuest)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.goldColor, AppTheme.goldLight],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline, size: 40, color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'ضيف',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'سجل دخول للاستفادة من جميع الميزات',
                      style: TextStyle(color: Colors.grey[500], fontFamily: 'Changa'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text('تسجيل الدخول', style: TextStyle(fontFamily: 'Changa')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _menuItems[index];
                  return GestureDetector(
                    onTap: () {
                      if (item['screen'] != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => item['screen']),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item['icon'] as IconData, color: item['color']),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Colors.black87,
                                fontFamily: 'Changa',
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _menuItems.length,
              ),
            ),
          ),
          if (!widget.isGuest)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: AppTheme.error),
                    label: const Text(
                      'تسجيل الخروج',
                      style: TextStyle(color: AppTheme.error, fontFamily: 'Changa'),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.error),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Changa'),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'Changa'),
        ),
      ],
    );
  }
}
