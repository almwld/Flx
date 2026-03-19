import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
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

class _MainNavigationState extends State<MainNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0; // الرئيسية هي default
  late AnimationController _pulseController;
  
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // ترتيب الشاشات حسب الفهارس
    _screens = [
      const HomeScreen(),         // 0: الرئيسية
      const AllAdsScreen(),       // 1: المتجر
      const MapScreen(),          // 2: الخريطة
      const ChatScreen(),         // 3: الدردشة
      const WalletScreen(),       // 4: المحفظة
      ProfileScreen(isGuest: widget.isGuest), // 5: حسابي
    ];
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
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
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // الأزرار اليسرى (الرئيسية، المتجر، الخريطة)
            _buildNavItem(0, 'home.svg', 'الرئيسية'),
            _buildNavItem(1, 'search.svg', 'المتجر'),
            _buildNavItem(2, 'location.svg', 'الخريطة'),
            
            // الزر الذهبي المركزي (إضافة إعلان)
            _buildCenterButton(),
            
            // الأزرار اليمنى (دردشة، محفظة، حسابي)
            _buildNavItem(3, 'chat.svg', 'دردشة'),
            _buildNavItem(4, 'wallet.svg', 'محفظة'),
            _buildNavItem(5, 'profile.svg', 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? AppTheme.goldColor.withOpacity(0.15) : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  'assets/icons/svg/$iconName',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400]! : Colors.grey[600]!),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400] : Colors.grey[600]),
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Changa',
                ),
                child: Text(label),
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
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.goldColor, AppTheme.goldLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.goldColor.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 35,
        ),
      ).animate(
        controller: _pulseController,
      ).scale(
        begin: const Offset(1, 1),
        end: const Offset(1.1, 1.1),
        duration: 1500.ms,
        curve: Curves.easeInOut,
      ),
    );
  }
}
