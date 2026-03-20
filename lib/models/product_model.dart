import 'dart:convert';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? oldPrice;
  final String currency;
  final List<String> images;
  final String category;
  final String subCategory;
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final String? sellerAvatar;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final int? discountPercentage;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.currency,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.sellerId,
    required this.sellerName,
    required this.sellerRating,
    this.sellerAvatar,
    required this.inStock,
    required this.rating,
    required this.reviewCount,
    this.isFeatured = false,
    this.discountPercentage,
    required this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] != null) {
      if (json['images'] is List) {
        imagesList = List<String>.from(json['images']);
      } else if (json['images'] is String) {
        try {
          imagesList = List<String>.from(jsonDecode(json['images']));
        } catch (e) {
          imagesList = [json['images'].toString()];
        }
      }
    }

    double? oldPrice;
    if (json['old_price'] != null) {
      oldPrice = (json['old_price'] as num).toDouble();
    } else if (json['discount_percentage'] != null && json['price'] != null) {
      final discount = (json['discount_percentage'] as num).toDouble();
      final price = (json['price'] as num).toDouble();
      oldPrice = price / (1 - discount / 100);
    }

    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? json['name'] ?? 'منتج غير معروف',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: oldPrice,
      currency: json['currency'] ?? 'YER',
      images: imagesList,
      category: json['category'] ?? '',
      subCategory: json['sub_category'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? json['profiles']?['full_name'] ?? 'متجر غير معروف',
      sellerRating: (json['seller_rating'] ?? json['profiles']?['rating'] ?? 0).toDouble(),
      sellerAvatar: json['seller_avatar'] ?? json['profiles']?['avatar_url'],
      inStock: json['in_stock'] ?? json['stock_quantity'] > 0 ?? true,
      rating: (json['rating'] ?? json['average_rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? json['total_reviews'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      discountPercentage: json['discount_percentage'] != null 
          ? (json['discount_percentage'] as num).toInt() : null,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'currency': currency,
      'images': images,
      'category': category,
      'sub_category': subCategory,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_rating': sellerRating,
      'seller_avatar': sellerAvatar,
      'in_stock': inStock,
      'rating': rating,
      'review_count': reviewCount,
      'is_featured': isFeatured,
      'discount_percentage': discountPercentage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get formattedPrice {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(1)}M';
    else if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
    return price.toStringAsFixed(0);
  }

  String get currencySymbol {
    switch (currency) {
      case 'YER': return 'ر.ي';
      case 'SAR': return 'ر.س';
      case 'USD': return '\$';
      default: return currency;
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    if (difference.inDays > 365) return 'منذ ${difference.inDays ~/ 365} سنة';
    else if (difference.inDays > 30) return 'منذ ${difference.inDays ~/ 30} شهر';
    else if (difference.inDays > 0) return 'منذ ${difference.inDays} يوم';
    else if (difference.inHours > 0) return 'منذ ${difference.inHours} ساعة';
    else if (difference.inMinutes > 0) return 'منذ ${difference.inMinutes} دقيقة';
    else return 'الآن';
  }
}
