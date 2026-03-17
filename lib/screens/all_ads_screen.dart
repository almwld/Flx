import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'all_ads_screen_part1.dart';
import 'all_ads_screen_part2.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'جميع الأقسام',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الجزء الأول'),
              Tab(text: 'الجزء الثاني'),
            ],
            indicatorColor: AppTheme.goldColor,
            labelColor: AppTheme.goldColor,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: const TabBarView(
          children: [
            AllAdsScreenPart1(),
            AllAdsScreenPart2(),
          ],
        ),
      ),
    );
  }
}
