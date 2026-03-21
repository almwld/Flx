import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import '../screens/notifications_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final double height;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.height = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        final isDark = themeManager.isDarkMode;
        return AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          title: title != null
              ? Text(
                  title!,
                  style: const TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Changa',
                  ),
                )
              : Row(
                  children: [
                    const Text(
                      'FLEX',
                      style: TextStyle(
                        color: AppTheme.goldColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: 'Changa',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'YEMEN',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.goldLight,
                        fontFamily: 'Changa',
                      ),
                    ),
                  ],
                ),
          actions: actions ??
              [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: themeManager.toggleTheme,
                  color: isDark ? Colors.amber : Colors.grey,
                ),
              ],
          backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          foregroundColor: isDark ? AppTheme.darkText : AppTheme.lightText,
          elevation: 0,
          centerTitle: true,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
