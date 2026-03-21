import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'my_orders_screen.dart';
import 'account_info_screen.dart';
import 'settings/settings_screen.dart';
import 'help_support_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isGuest;
  const ProfileScreen({super.key, this.isGuest = false});
  @override State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userData;
  bool _isLoading = true;

  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'إعلاناتي', 'icon': Icons.campaign, 'color': Colors.blue, 'screen': const MyAdsScreen()},
    {'title': 'المفضلة', 'icon': Icons.favorite, 'color': Colors.red, 'screen': const FavoritesScreen()},
    {'title': 'طلباتي', 'icon': Icons.shopping_bag, 'color': Colors.green, 'screen': const MyOrdersScreen()},
    {'title': 'معلومات الحساب', 'icon': Icons.person, 'color': Colors.orange, 'screen': const AccountInfoScreen()},
    {'title': 'الإعدادات', 'icon': Icons.settings, 'color': Colors.purple, 'screen': const SettingsScreen()},
    {'title': 'المساعدة والدعم', 'icon': Icons.help_outline, 'color': Colors.teal, 'screen': const HelpSupportScreen()},
    {'title': 'عن التطبيق', 'icon': Icons.info_outline, 'color': Colors.cyan, 'screen': const AboutScreen()},
  ];

  @override
  void initState() {
    super.initState();
    if (!widget.isGuest && SupabaseService.isAuthenticated) {
      _loadUserData();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadUserData() async {
    final user = SupabaseService.currentUser;
    if (user != null) {
      _userData = await SupabaseService.getUserProfile(user.id);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'حسابي'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                if (!widget.isGuest && _userData != null)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
                              shape: BoxShape.circle,
                            ),
                            child: _userData!.avatarUrl != null
                                ? ClipOval(child: Image.network(_userData!.avatarUrl!, fit: BoxFit.cover))
                                : const Icon(Icons.person, size: 40, color: Colors.black),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userData!.fullName,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(_userData!.email ?? '', style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildStatItem(_userData!.rating.toStringAsFixed(1), 'التقييم'),
                                    const SizedBox(width: 16),
                                    _buildStatItem(_userData!.followers.toString(), 'المتابعون'),
                                    const SizedBox(width: 16),
                                    _buildStatItem(_userData!.adsCount.toString(), 'الإعلانات'),
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
                              gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person_outline, size: 40, color: Colors.black),
                          ),
                          const SizedBox(height: 12),
                          const Text('ضيف', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            'سجل دخول للاستفادة من جميع الميزات',
                            style: TextStyle(color: Colors.grey[500]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              ),
                              child: const Text('تسجيل الدخول'),
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
                      (_, i) {
                        final item = _menuItems[i];
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item['screen'])),
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
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                          onPressed: () async {
                            await SupabaseService.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const ProfileScreen(isGuest: true)),
                            );
                          },
                          icon: const Icon(Icons.logout, color: AppTheme.error),
                          label: const Text('تسجيل الخروج', style: TextStyle(color: AppTheme.error)),
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
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
