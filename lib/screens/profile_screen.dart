import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class ProfileScreen extends StatelessWidget { final bool isGuest; const ProfileScreen({super.key, this.isGuest = false}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'حسابي'), body: Center(child: Text('قيد الإعداد'))); }
