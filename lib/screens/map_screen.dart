import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'الخريطة'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/svg/location.svg',
              width: 100,
              height: 100,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.grey[700]! : Colors.grey[300]!,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'قريباً',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'خدمة الخرائط قيد التطوير',
              style: TextStyle(
                fontFamily: 'Changa',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
