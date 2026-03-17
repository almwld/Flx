import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'wallet_screen.dart';
import 'add_ad_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'all_ads_screen.dart';
import 'cart_screen.dart';
import 'map_screen.dart';

class MainNavigation extends StatefulWidget {
  final bool isGuest;
  const MainNavigation({super.key, this.isGuest = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _screens = [
      const HomeScreen(),
      const AllAdsScreen(),
      const MapScreen(),
      const WalletScreen(),
      const CartScreen(),
      const ChatScreen(),
      ProfileScreen(isGuest: widget.isGuest),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    _animationController.reset();
    _animationController.forward();
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
            _buildNavItem(0, 'home.svg', 'الرئيسية'),
            _buildNavItem(1, 'search.svg', 'المتجر'),
            _buildNavItem(2, 'location.svg', 'الخريطة'),
            _buildCenterButton(),
            _buildNavItem(3, 'wallet.svg', 'المحفظة'),
            _buildNavItem(4, 'cart.svg', 'السلة'),
            _buildNavItem(5, 'chat.svg', 'المحادثات'),
            _buildNavItem(6, 'profile.svg', 'حسابي'),
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
                ).animate(
                  onPlay: isSelected ? (controller) => controller.repeat(reverse: true) : null,
                ).shimmer(
                  duration: 1500.ms,
                  color: isSelected ? Colors.white : Colors.transparent,
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
    final isSelected = _currentIndex == 2; // الخريطة في المنتصف
    
    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: Container(
        width: 65,
        height: 65,
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
              spreadRadius: isSelected ? 3 : 0,
            ),
          ],
        ),
        child: SvgPicture.asset(
          'assets/icons/svg/location.svg',
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 30,
          height: 30,
          fit: BoxFit.scaleDown,
        ).animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        ).scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 1500.ms,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
