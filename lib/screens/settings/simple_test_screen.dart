import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';

class SimpleTestScreen extends StatelessWidget {
  const SimpleTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختبار بسيط'),
      ),
      body: const Center(
        child: Text(
          'إذا ظهر هذا النص، فالمشكلة ليست في التنقل',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
