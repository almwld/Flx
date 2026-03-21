import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import 'wallet/deposit_screen.dart';
import 'wallet/withdraw_screen.dart';
import 'wallet/transfer_screen.dart';
import 'wallet/payments_screen.dart';
import 'wallet/transactions_screen.dart';
import 'wallet/games_screen.dart';
import 'wallet/apps_screen.dart';
import 'wallet/gift_cards_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCard = 0;
  bool _isHidden = false;
  double _yerBalance = 125000;
  double _sarBalance = 5000;
  double _usdBalance = 200;

  final List<Map<String, dynamic>> _services = [
    {'name': 'إيداع', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'فواتير', 'icon': Icons.receipt, 'color': Colors.purple, 'screen': const PaymentsScreen()},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'screen': const GamesScreen()},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.cyan, 'screen': const AppsScreen()},
    {'name': 'بطاقات', 'icon': Icons.card_giftcard, 'color': Colors.brown, 'screen': const GiftCardsScreen()},
    {'name': 'عمليات', 'icon': Icons.history, 'color': Colors.teal, 'screen': const TransactionsScreen()},
  ];

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final wallet = await SupabaseService.getWallet();
    if (wallet != null) {
      setState(() {
        _yerBalance = wallet.yerBalance;
        _sarBalance = wallet.sarBalance;
        _usdBalance = wallet.usdBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'المحفظة',
        actions: [
          IconButton(
            icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _isHidden = !_isHidden),
            color: AppTheme.goldColor,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: 3,
                onPageChanged: (i) => setState(() => _currentCard = i),
                itemBuilder: (_, i) {
                  final card = i == 0
                      ? {'name': 'الريال اليمني', 'balance': _yerBalance, 'flag': '🇾🇪', 'currency': 'YER'}
                      : i == 1
                          ? {'name': 'الريال السعودي', 'balance': _sarBalance, 'flag': '🇸🇦', 'currency': 'SAR'}
                          : {'name': 'الدولار الأمريكي', 'balance': _usdBalance, 'flag': '🇺🇸', 'currency': 'USD'};
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
                              Text(card[.flag.] as String, style: const TextStyle(fontSize: 30)),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  card[.currency.] as String,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(card[.name.] as String, style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            _isHidden ? '••••••' : '${(card[.balance.] as num).toDouble().toStringAsFixed(0)} ر.ي',
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentCard == i ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentCard == i
                        ? AppTheme.goldColor
                        : (isDark ? Colors.grey[700] : Colors.grey[300]),
                  ),
                )),
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
                          Text(
                            s['name'],
                            style: const TextStyle(fontSize: 11, fontFamily: 'Changa'),
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
