import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'wallet_screen.dart';
import 'add_ad_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'all_ads_screen.dart';

class MainNavigation extends StatefulWidget {
  final bool isGuest;
  const MainNavigation({super.key, this.isGuest = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const WalletScreen(),
      const AddAdScreen(),
      const ChatScreen(),
      ProfileScreen(isGuest: widget.isGuest),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.person_outline, 'حسابي', 4),
            _buildNavItem(Icons.chat_bubble_outline, 'المحادثات', 3),
            _buildNavItem(Icons.account_balance_wallet_outlined, 'المحفظة', 1),
            _buildCenterButton(),
            _buildNavItem(Icons.home_outlined, 'الرئيسية', 0),
            _buildNavItem(Icons.shopping_bag_outlined, 'المتجر', 0),
            _buildNavItem(Icons.add_circle_outline, 'إضافة', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400] : Colors.grey[600])),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400] : Colors.grey[600]), fontSize: 11, fontFamily: 'Changa')),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppTheme.goldColor.withOpacity(0.4), blurRadius: 10)],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}
