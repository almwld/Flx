import 'dart:convert';

class RatingModel {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final double rating;
  final String? comment;
  final List<String>? images;
  final DateTime createdAt;

  RatingModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    this.comment,
    this.images,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    List<String>? imagesList;
    if (json['images'] != null) {
      if (json['images'] is List) {
        imagesList = List<String>.from(json['images']);
      } else if (json['images'] is String) {
        try {
          imagesList = List<String>.from(jsonDecode(json['images']));
        } catch (e) {
          imagesList = [];
        }
      }
    }

    return RatingModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? json['profiles']?['full_name'] ?? 'مستخدم',
      userAvatar: json['user_avatar'] ?? json['profiles']?['avatar_url'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'],
      images: imagesList,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  String get formattedDate {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    if (diff.inDays > 365) return 'منذ ${diff.inDays ~/ 365} سنة';
    else if (diff.inDays > 30) return 'منذ ${diff.inDays ~/ 30} شهر';
    else if (diff.inDays > 0) return 'منذ ${diff.inDays} يوم';
    else if (diff.inHours > 0) return 'منذ ${diff.inHours} ساعة';
    else if (diff.inMinutes > 0) return 'منذ ${diff.inMinutes} دقيقة';
    else return 'الآن';
  }
}
