import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'products_screen.dart';

class AllAdsScreen extends StatelessWidget {
  const AllAdsScreen({super.key});
  @override
  Widget build(BuildContext context) => ProductsScreen(category: 'الكل');
}
