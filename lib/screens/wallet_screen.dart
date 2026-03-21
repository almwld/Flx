import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'wallet/deposit_screen.dart';
import 'wallet/withdraw_screen.dart';
import 'wallet/transfer_screen.dart';
import 'wallet/transactions_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _cards = const [
    {'currency': 'YER', 'balance': 125000, 'symbol': 'ر.ي', 'name': 'الريال اليمني', 'flag': '🇾🇪'},
    {'currency': 'SAR', 'balance': 5000, 'symbol': 'ر.س', 'name': 'الريال السعودي', 'flag': '🇸🇦'},
    {'currency': 'USD', 'balance': 200, 'symbol': '\$', 'name': 'الدولار الأمريكي', 'flag': '🇺🇸'},
  ];

  // إزالة const من هنا لأن القائمة تحتوي على كائنات غير ثابتة
  final List<Map<String, dynamic>> _services = [
    {'name': 'إيداع', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'عمليات', 'icon': Icons.history, 'color': Colors.teal, 'screen': const TransactionsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'المحفظة'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: _cards.length,
                itemBuilder: (_, i) {
                  final card = _cards[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.goldColor, AppTheme.goldLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(card['flag'], style: const TextStyle(fontSize: 30)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(card['currency'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(card['name'], style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            '${card['balance']} ${card['symbol']}',
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final s = _services[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => s['screen'])),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (s['color'] as Color).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(s['icon'], color: s['color'], size: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(s['name'], style: const TextStyle(fontSize: 11)),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
