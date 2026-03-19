import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import 'wallet_screen.dart';
import 'add_ad_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings/settings_screen.dart';
import 'all_ads_screen.dart';
import 'map_screen.dart';

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
      const AllAdsScreen(),
      const MapScreen(),
      const ChatScreen(),
      const WalletScreen(),
      ProfileScreen(isGuest: widget.isGuest),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 75,
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, 'home.svg', 'الرئيسية', isDark),
            _buildNavItem(1, 'search.svg', 'المتجر', isDark),
            _buildNavItem(2, 'location.svg', 'الخريطة', isDark),
            _buildCenterButton(),
            _buildNavItem(3, 'chat.svg', 'دردشة', isDark),
            _buildNavItem(4, 'wallet.svg', 'محفظة', isDark),
            _buildNavItem(5, 'profile.svg', 'حسابي', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName, String label, bool isDark) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/svg/$iconName',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected ? const Color(0xFFD4AF37) : (isDark ? Colors.grey[400]! : Colors.grey[600]!),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFFD4AF37) : (isDark ? Colors.grey[400] : Colors.grey[600]),
                  fontSize: 10,
                  fontFamily: 'Changa',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddAdScreen()),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFF4E4BC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 35),
      ),
    );
  }
}
