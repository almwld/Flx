import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';

class ProductReviewScreen extends StatefulWidget {
  final ProductModel product;
  const ProductReviewScreen({super.key, required this.product});
  @override State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  double _rating = 0;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء اختيار تقييم')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      await SupabaseService.addRating(
        productId: widget.product.id,
        rating: _rating,
        comment: _commentController.text.isNotEmpty ? _commentController.text : null,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة تقييمك بنجاح'), backgroundColor: AppTheme.success));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e'), backgroundColor: AppTheme.error));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تقييم المنتج'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('قيم هذا المنتج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(widget.product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      i < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(_rating == 0 ? 'اختر التقييم' : 'تقييم: $_rating من 5', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            CustomTextField(controller: _commentController, label: 'اكتب تعليقك (اختياري)', maxLines: 4),
            const SizedBox(height: 24),
            CustomButton(text: 'إرسال التقييم', onPressed: _submitReview, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
