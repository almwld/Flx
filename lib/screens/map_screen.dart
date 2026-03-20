import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
class MapScreen extends StatelessWidget { const MapScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(appBar: CustomAppBar(title: 'الخريطة'), body: Center(child: Text('قيد الإعداد'))); }
