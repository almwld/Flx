import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class WalletScreen extends StatelessWidget { const WalletScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'المحفظة'), body: Center(child: Text('قيد الإعداد'))); }
