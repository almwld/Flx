import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';

class AdCard extends StatelessWidget {
  final ProductModel product; final VoidCallback onTap;
  const AdCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldColor.withOpacity(0.3))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 3, child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: CachedNetworkImage(
            imageUrl: product.images.isNotEmpty ? product.images.first : '', fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: isDark ? AppTheme.darkSurface : Colors.grey[300]),
            errorWidget: (_, __, ___) => Container(color: isDark ? AppTheme.darkSurface : Colors.grey[300], child: Icon(Icons.broken_image, color: isDark ? Colors.grey[600] : Colors.grey[400])),
          ))),
          Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.title, style: TextStyle(fontFamily: 'Changa', fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? AppTheme.darkText : AppTheme.lightText), maxLines: 1, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Row(children: [
              if (product.oldPrice != null) Text(product.oldPrice!, style: const TextStyle(fontFamily: 'Changa', fontSize: 10, color: Colors.grey, decoration: TextDecoration.lineThrough)),
              const SizedBox(width: 4),
              Expanded(child: Text('${product.formattedPrice} ${product.currencySymbol}', style: const TextStyle(fontFamily: 'Changa', fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.goldColor))),
            ]),
            const SizedBox(height: 4),
            Row(children: [Icon(Icons.location_on, size: 10, color: isDark ? Colors.grey[400] : Colors.grey[600]), const SizedBox(width: 2),
              Expanded(child: Text(product.sellerName, style: TextStyle(fontFamily: 'Changa', fontSize: 9, color: isDark ? Colors.grey[400] : Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis)),
              const Spacer(), Icon(Icons.favorite_border, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
            ]),
          ]))),
        ]),
      ),
    );
  }
}
