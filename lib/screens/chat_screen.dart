import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class ChatScreen extends StatelessWidget { const ChatScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'المحادثات'), body: Center(child: Text('قيد الإعداد'))); }
