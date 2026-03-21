class UserModel {
  final String id;
  final String fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String userType; // 'customer' or 'merchant'
  final String? city;
  final double rating;
  final int followers;
  final int following;
  final int adsCount;
  final bool isVerified;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.avatarUrl,
    required this.userType,
    this.city,
    this.rating = 0.0,
    this.followers = 0,
    this.following = 0,
    this.adsCount = 0,
    this.isVerified = false,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      userType: json['user_type'] ?? 'customer',
      city: json['city'],
      rating: (json['rating'] ?? 0).toDouble(),
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      adsCount: json['ads_count'] ?? 0,
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }
}
