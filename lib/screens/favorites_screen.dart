import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/empty_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'المفضلة'),
      body: const EmptyState(
        icon: Icons.favorite_border,
        title: 'لا توجد عناصر في المفضلة',
        message: 'أضف منتجات إلى المفضلة لتظهر هنا',
      ),
    );
  }
}
