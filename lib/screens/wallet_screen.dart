import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'wallet/deposit_screen.dart';
import 'wallet/withdraw_screen.dart';
import 'wallet/transfer_screen.dart';
import 'wallet/payments_screen.dart';
import 'wallet/apps_screen.dart';
import 'wallet/games_screen.dart';
import 'wallet/entertainment_screen.dart';
import 'wallet/transfer_network_screen.dart';
import 'wallet/banks_screen.dart';
import 'wallet/amazon_screen.dart';
import 'wallet/gift_cards_screen.dart';
import 'wallet/money_transfers_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCard = 0;
  bool _isHidden = false;

  // حذف الدولار من البطاقات (بقاء اليمني والسعودي فقط)
  final List<Map<String, dynamic>> _cards = [
    {'name': 'الريال اليمني', 'balance': 125000, 'currency': 'YER', 'flag': '🇾🇪', 'color': AppTheme.goldColor},
    {'name': 'الريال السعودي', 'balance': 5000, 'currency': 'SAR', 'flag': '🇸🇦', 'color': Colors.green[700]!},
  ];

  final List<Map<String, dynamic>> _services = [
    {'name': 'إيداع', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'فواتير', 'icon': Icons.receipt, 'color': Colors.purple, 'screen': const PaymentsScreen()},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.cyan, 'screen': const AppsScreen()},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'screen': const GamesScreen()},
    {'name': 'ترفيه', 'icon': Icons.movie, 'color': Colors.pink, 'screen': const EntertainmentScreen()},
    {'name': 'شبكة تحويل', 'icon': Icons.settings_ethernet, 'color': Colors.teal, 'screen': const TransferNetworkScreen()},
    {'name': 'بنوك', 'icon': Icons.account_balance, 'color': Colors.indigo, 'screen': const BanksScreen()},
    {'name': 'أمازون', 'icon': Icons.shopping_cart, 'color': Colors.amber, 'screen': const AmazonScreen()},
    {'name': 'بطاقة نت', 'icon': Icons.card_giftcard, 'color': Colors.brown, 'screen': const GiftCardsScreen()},
    {'name': 'تحويلات', 'icon': Icons.compare_arrows, 'color': Colors.lightBlue, 'screen': const MoneyTransfersScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'المحفظة',
        actions: [
          // زر إخفاء/إظهار الرصيد
          IconButton(
            icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
            color: AppTheme.goldColor,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // بطاقات الرصيد
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: _cards.length,
                onPageChanged: (index) => setState(() => _currentCard = index),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [card['color'], card['color'].withOpacity(0.8)],
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
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                                child: Text(card['currency'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(card['name'], style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            _isHidden ? '••••••' : '${card['balance']} ر.ي',
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
          // نقاط التمرير
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_cards.length, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentCard == i ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentCard == i ? AppTheme.goldColor : (isDark ? Colors.grey[700] : Colors.grey[300]),
                  ),
                )),
              ),
            ),
          ),
          // شبكة الخدمات
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = _services[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => service['screen'])),
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
                              color: (service['color'] as Color).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(service['icon'], color: service['color'], size: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service['name'],
                            style: const TextStyle(fontSize: 12, fontFamily: 'Changa'),
                            textAlign: TextAlign.center,
                          ),
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
