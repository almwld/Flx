import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اختبار'),
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'صفحة اختبار تعمل',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
