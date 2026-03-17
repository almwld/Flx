import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
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
    {'title': 'معلومات الحساب', 'icon': Icons.person, 'color': Colors.green, 'screen': const AccountInfoScreen()},
    {'title': 'الإعدادات', 'icon': Icons.settings, 'color': Colors.purple, 'screen': const SettingsScreen()},
    {'title': 'المساعدة والدعم', 'icon': Icons.help_outline, 'color': Colors.orange, 'screen': null},
    {'title': 'عن التطبيق', 'icon': Icons.info_outline, 'color': Colors.teal, 'screen': null},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'حسابي'),
      body: CustomScrollView(
        slivers: [
          // معلومات المستخدم
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
                        Text(
                          widget.isGuest ? 'ضيف' : 'أحمد محمد',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppTheme.darkText : AppTheme.lightText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.isGuest 
                              ? 'سجل دخول للاستفادة من جميع الميزات'
                              : 'ahmed@example.com',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // إحصائيات
          if (!widget.isGuest)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('الإعلانات', '12'),
                    Container(width: 1, height: 40, color: Colors.grey[700]),
                    _buildStatItem('المفضلة', '45'),
                    Container(width: 1, height: 40, color: Colors.grey[700]),
                    _buildStatItem('المشاهدات', '1.2K'),
                  ],
                ),
              ),
            ),
          
          // قائمة الخيارات
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
          
          // زر تسجيل الخروج
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: widget.isGuest
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        }
                      : () {},
                  icon: Icon(widget.isGuest ? Icons.login : Icons.logout, color: Colors.white),
                  label: Text(
                    widget.isGuest ? 'تسجيل الدخول' : 'تسجيل الخروج',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
