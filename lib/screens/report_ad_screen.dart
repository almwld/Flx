import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ReportAdScreen extends StatefulWidget {
  const ReportAdScreen({super.key});
  @override State<ReportAdScreen> createState() => _ReportAdScreenState();
}

class _ReportAdScreenState extends State<ReportAdScreen> {
  String? _reason;
  final _detailsController = TextEditingController();
  final List<String> _reasons = ['إعلان مخالف', 'محتوى غير لائق', 'انتحال شخصية', 'احتيال', 'أخرى'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإبلاغ عن إعلان'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _reason,
              hint: const Text('اختر سبب الإبلاغ'),
              items: _reasons.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (v) => setState(() => _reason = v),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: _detailsController, label: 'تفاصيل إضافية (اختياري)', maxLines: 3),
            const SizedBox(height: 24),
            CustomButton(
              text: 'إرسال البلاغ',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال البلاغ بنجاح')));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
