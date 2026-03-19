import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';
import '../providers/theme_manager.dart';
import '../screens/cart_screen.dart';

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
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = Provider.of<ThemeManager>(context);

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: AppTheme.goldColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Changa',
                fontSize: 18.sp,
              ),
            )
          : Row(
              children: [
                Text(
                  'FLEX',
                  style: TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontFamily: 'Changa',
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'YEMEN',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.goldLight,
                    fontFamily: 'Changa',
                  ),
                ),
              ],
            ),
      actions: actions ??
          [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, size: 24.r),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                ),
                Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.r,
                      minHeight: 16.r,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                size: 24.r,
              ),
              onPressed: () => themeManager.toggleTheme(),
              color: isDark ? Colors.amber : Colors.grey,
            ),
          ],
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
      foregroundColor: isDark ? AppTheme.darkText : AppTheme.lightText,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}
