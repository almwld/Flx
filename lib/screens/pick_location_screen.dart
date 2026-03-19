import 'package:flex_yemen/models/rating_model.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  String _selectedLocation = 'لم يتم الاختيار';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اختر الموقع'),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('حرك الخريطة لاختيار الموقع', style: TextStyle(fontFamily: 'Changa')),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkCard
                    : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text('الموقع المختار: $_selectedLocation', style: const TextStyle(fontFamily: 'Changa')),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'تأكيد الموقع',
                    onPressed: () {
                      Navigator.pop(context, _selectedLocation);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
