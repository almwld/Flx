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
  final bool inStock;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;

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
    required this.inStock,
    required this.rating,
    required this.reviewCount,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price'] != null ? (json['old_price'] as num).toDouble() : null,
      currency: json['currency'] ?? 'YER',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      subCategory: json['sub_category'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerRating: (json['seller_rating'] ?? 0).toDouble(),
      inStock: json['in_stock'] ?? true,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
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
      'in_stock': inStock,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
