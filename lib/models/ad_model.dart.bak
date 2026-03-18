import 'package:flutter/material.dart';

class AdModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String currency;
  final List<String> images;
  final String category;
  final String subCategory;
  final String city;
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final DateTime createdAt;
  final bool isOffer;
  final bool isFeatured;
  final bool isAuction;
  final int? discountPercentage;
  final String? oldPrice;
  final DateTime? auctionEndTime;
  final double? currentBid;
  final int? bidCount;
  final int views;           // عدد المشاهدات
  final String status;       // حالة الإعلان (active, sold, expired)

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.city,
    required this.sellerId,
    required this.sellerName,
    required this.sellerRating,
    required this.createdAt,
    this.isOffer = false,
    this.isFeatured = false,
    this.isAuction = false,
    this.discountPercentage,
    this.oldPrice,
    this.auctionEndTime,
    this.currentBid,
    this.bidCount,
    this.views = 0,          // القيمة الافتراضية
    this.status = 'active',   // القيمة الافتراضية
  });

  String get formattedPrice {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    }
    return price.toStringAsFixed(0);
  }

  String get currencySymbol {
    switch (currency) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      default:
        return currency;
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return 'منذ ${difference.inDays ~/ 365} سنة';
    } else if (difference.inDays > 30) {
      return 'منذ ${difference.inDays ~/ 30} شهر';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}
