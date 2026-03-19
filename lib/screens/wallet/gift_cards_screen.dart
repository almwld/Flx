import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String? _selectedCard;
  final List<Map<String, dynamic>> _cards = const [
    {'name': 'جوجل بلاي', 'icon': Icons.android, 'color': Colors.green, 'prices': ['50,000', '100,000', '200,000']},
    {'name': 'آيتونز', 'icon': Icons.apple, 'color': Colors.grey, 'prices': ['30,000', '60,000', '120,000']},
    {'name': 'ستيم', 'icon': Icons.computer, 'color': Colors.blue, 'prices': ['40,000', '80,000', '160,000']},
    {'name': 'بلاي ستيشن', 'icon': Icons.games, 'color': Colors.indigo, 'prices': ['25,000', '50,000', '100,000']},
  ];

  String? _selectedPrice;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'بطاقات نت'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: _cards.map((card) {
                final isSelected = _selectedCard == card['name'];
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedCard = card['name'];
                    _selectedPrice = null;
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? (card['color'] as Color).withOpacity(0.2) : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? card['color'] : Colors.transparent, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(card['icon'] as IconData, color: card['color'], size: 40),
                        const SizedBox(height: 8),
                        Text(card['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedCard != null) ...[
              const Text('اختر الفئة', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _cards.firstWhere((c) => c['name'] == _selectedCard)['prices'].map<Widget>((price) {
                  final isSelected = _selectedPrice == price;
                  return FilterChip(
                    label: Text('$price ر.ي'),
                    selected: isSelected,
                    onSelected: (v) => setState(() => _selectedPrice = price),
                    backgroundColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                    selectedColor: AppTheme.goldColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'شراء البطاقة',
                onPressed: _selectedPrice == null
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم شراء بطاقة $_selectedCard بقيمة $_selectedPrice ريال')),
                          );
                          Navigator.pop(context);
                        });
                      },
                isLoading: _isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
