import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final double height;
  const CustomAppBar({super.key, this.title, this.actions, this.height = 56.0});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        final isDark = themeManager.isDarkMode;
        return AppBar(
          title: title != null
              ? Text(title!, style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold))
              : Row(children: [
                  const Text('FLEX', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Text('YEMEN', style: TextStyle(fontSize: 14, color: AppTheme.goldLight)),
                ]),
          actions: actions ?? [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: themeManager.toggleTheme,
              color: isDark ? Colors.amber : Colors.grey,
            ),
          ],
          backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          elevation: 0,
          centerTitle: true,
        );
      },
    );
  }
  @override Size get preferredSize => Size.fromHeight(height);
}
