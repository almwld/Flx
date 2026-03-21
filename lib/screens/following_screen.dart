import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        appBar: SimpleAppBar(
          title: 'المتابعين',
          bottom: const TabBar(
            tabs: [Tab(text: 'المتابعين'), Tab(text: 'المتابَعين')],
            labelStyle: TextStyle(fontFamily: 'Changa'),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: AppTheme.goldColor, child: Icon(Icons.person, color: Colors.white)),
                  title: Text('متابع ${index + 1}', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
                  trailing: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: AppTheme.darkText), child: const Text('متابعة', style: TextStyle(fontFamily: 'Changa'))),
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: AppTheme.goldColor, child: Icon(Icons.person, color: Colors.white)),
                  title: Text('متابَع ${index + 1}', style: TextStyle(fontFamily: 'Changa', color: AppTheme.getTextColor(context))),
                  trailing: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, foregroundColor: Colors.white), child: const Text('إلغاء', style: TextStyle(fontFamily: 'Changa'))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
