class ServiceModel {
  final int id;
  final int categoryId;
  final String name;
  final String price;
  final double discount;
  final String estimatedTime;
  final double rating;
  final int reviews;
  final bool isPopular;
  final String imageUrl;
  final String details;

  ServiceModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.discount,
    required this.estimatedTime,
    required this.rating,
    required this.reviews,
    required this.isPopular,
    required this.imageUrl,
    required this.details,
  });

  // Factory constructor to create a ServiceModel from a map
factory ServiceModel.fromMap(Map<String, dynamic> map) {
  return ServiceModel(
    id: map['id'] as int? ?? 0, // Default to 0 if null
    categoryId: map['categoryId'] as int? ?? 0,
    name: map['name'] as String? ?? "Unknown Service",
    price: map['price'] as String? ?? "0/unit",
    discount: (map['discount'] as num?)?.toDouble() ?? 0.0,
    estimatedTime: map['estimatedTime'] as String? ?? "N/A",
    rating: (map['rating'] as num?)?.toDouble() ?? 0.0, 
    reviews: map['reviews'] as int? ?? 0,
    isPopular: map['isPopular'] as bool? ?? false,
    imageUrl: map['imageUrl'] as String? ?? "",
    details: map['details'] as String? ?? "No details available",
  );
}


  // Convert a ServiceModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'price': price,
      'discount': discount,
      'estimatedTime': estimatedTime,
      'rating': rating,
      'reviews': reviews,
      'isPopular': isPopular,
      'imageUrl': imageUrl,
      'details': details,
    };
  }

  // Convert a list of maps into a list of ServiceModel objects
  static List<ServiceModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ServiceModel.fromMap(map)).toList();
  }
}
