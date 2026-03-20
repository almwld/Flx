import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'الإعدادات'), body: Center(child: Text('قيد الإعداد'))); }
