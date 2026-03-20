import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class CheckoutItem { final Map<String, dynamic> product; final int quantity; CheckoutItem({required this.product, required this.quantity}); }
class CheckoutScreen extends StatelessWidget { final List<CheckoutItem> items; const CheckoutScreen({super.key, required this.items}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'إتمام الشراء'), body: Center(child: Text('قيد الإعداد'))); }
