import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../models/ad_model.dart';

class AdDetailScreen extends StatelessWidget {
  final AdModel ad;
  const AdDetailScreen({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageUrl = ad.images.isNotEmpty ? ad.images[0] : 'https://via.placeholder.com/400';

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الإعلان
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(height: 250, color: Colors.grey[300]),
              errorWidget: (context, url, error) => Container(height: 250, color: Colors.grey[300], child: const Icon(Icons.error)),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          ad.title,
                          style: TextStyle(fontFamily: 'Changa', fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '${ad.formattedPrice} ${ad.currencySymbol}',
                          style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // الموقع
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(ad.city, style: TextStyle(color: Colors.grey[500])),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(ad.timeAgo, style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.person, color: AppTheme.goldColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ad.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 14),
                                  const SizedBox(width: 2),
                                  Text('${ad.sellerRating}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.chat), onPressed: () {}),
                            IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // الوصف
                  const Text('الوصف', style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(ad.description, style: const TextStyle(height: 1.5)),
                  
                  const SizedBox(height: 24),
                  
                  // أزرار الإجراء
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat),
                          label: const Text('محادثة', style: TextStyle(fontFamily: 'Changa')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone),
                          label: const Text('اتصال', style: TextStyle(fontFamily: 'Changa')),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.goldColor,
                            side: const BorderSide(color: AppTheme.goldColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.flag, color: Colors.red),
                      label: const Text('الإبلاغ عن الإعلان', style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
