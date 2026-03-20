import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});
  @override State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _all = true, _orders = true, _promos = false, _messages = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإشعارات'),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Column(children: [
          SwitchListTile(title: const Text('جميع الإشعارات'), value: _all, onChanged: (v) => setState(() { _all = v; _orders = v; _promos = v; _messages = v; })),
          const Divider(), SwitchListTile(title: const Text('تحديثات الطلبات'), value: _orders, onChanged: (v) => setState(() => _orders = v)),
          SwitchListTile(title: const Text('العروض'), value: _promos, onChanged: (v) => setState(() => _promos = v)),
          SwitchListTile(title: const Text('الرسائل'), value: _messages, onChanged: (v) => setState(() => _messages = v)) ])) ]));
  }
}
