class CategoryModel {
  final int categoryId;
  final String category;
  final String icon;
  final String basePrice;
  final String details;

  CategoryModel({
    required this.categoryId,
    required this.category,
    required this.icon,
    required this.basePrice,
    required this.details,
  });

  // ✅ Factory constructor to create Category from Map
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] ?? 0,
      category: map['category'] ?? '',
      icon: map['icon'] ?? '',
      basePrice: map['basePrice'] ?? '',
      details: map['details'] ?? '',
    );
  }

  // Convert a Category object to a Map
  Map<String, dynamic> toMap() {
    return {
      "categoryId": categoryId,
      "category": category,
      "icon": icon,
      "basePrice": basePrice,
      "details": details,
    };
  }
}
