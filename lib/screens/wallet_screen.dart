import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCard = 0; bool _isHidden = false; double _balance = 125000;
  final List<Map<String, dynamic>> _services = [
    {'name': 'إيداع', 'icon': Icons.add_card, 'color': Colors.orange, 'route': '/deposit'},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'route': '/withdraw'},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'route': '/transfer'},
    {'name': 'فواتير', 'icon': Icons.receipt, 'color': Colors.purple, 'route': '/bills'},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.cyan, 'route': '/apps'},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'route': '/games'},
    {'name': 'ترفيه', 'icon': Icons.movie, 'color': Colors.pink, 'route': '/entertainment'},
    {'name': 'شبكة تحويل', 'icon': Icons.settings_ethernet, 'color': Colors.teal, 'route': '/transfer_network'},
    {'name': 'بنوك', 'icon': Icons.account_balance, 'color': Colors.indigo, 'route': '/banks'},
    {'name': 'أمازون', 'icon': Icons.shopping_cart, 'color': Colors.amber, 'route': '/amazon'},
    {'name': 'بطاقة نت', 'icon': Icons.card_giftcard, 'color': Colors.brown, 'route': '/gift_cards'},
    {'name': 'تحويلات', 'icon': Icons.compare_arrows, 'color': Colors.lightBlue, 'route': '/money_transfers'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(title: 'المحفظة', actions: [
        IconButton(icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _isHidden = !_isHidden), color: AppTheme.goldColor)
      ]),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 200, child: PageView.builder(
          itemCount: 2, onPageChanged: (i) => setState(() => _currentCard = i),
          itemBuilder: (_, i) {
            final card = i == 0 ? {'name': 'الريال اليمني', 'balance': _balance, 'flag': '🇾🇪'} : {'name': 'الريال السعودي', 'balance': _balance ~/ 20, 'flag': '🇸🇦'};
            return Container(margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(24)),
              child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Text(card['flag'], style: const TextStyle(fontSize: 30)), const Spacer(),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: Text(i == 0 ? 'YER' : 'SAR', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))]),
                const Spacer(),
                Text(card['name'], style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 4),
                Text(_isHidden ? '••••••' : '${card['balance']} ر.ي', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))
              ]))); })),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(2, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 300), width: _currentCard == i ? 24 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _currentCard == i ? AppTheme.goldColor : (isDark ? Colors.grey[700] : Colors.grey[300]))))))),
        SliverPadding(padding: const EdgeInsets.all(16), sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 12, mainAxisSpacing: 12),
          delegate: SliverChildBuilderDelegate((_, i) {
            final s = _services[i];
            return GestureDetector(onTap: () => _navigateToService(context, s['route']),
              child: Container(decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: (s['color'] as Color).withOpacity(0.2), shape: BoxShape.circle),
                    child: Icon(s['icon'], color: s['color'], size: 28)),
                  const SizedBox(height: 8),
                  Text(s['name'], style: const TextStyle(fontSize: 12, fontFamily: 'Changa'), textAlign: TextAlign.center) ]))); },
            childCount: _services.length))),
      ]),
    );
  }

  void _navigateToService(BuildContext context, String route) {
    // مؤقتاً نعرض رسالة
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('سيتم إضافة خدمة $route قريباً')));
  }
}
