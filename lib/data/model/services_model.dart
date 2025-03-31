class Service {
  final int id;
  final int categoryId;
  final String name;
  final String price;
  final int discount;
  final String estimatedTime;
  final double rating;
  final int reviews;
  final bool isPopular;
  final String imageUrl;
  final String details;

  Service({
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

  // Factory constructor to create a Service from a Map
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map["id"],
      categoryId: map["categoryId"],
      name: map["name"],
      price: map["price"],
      discount: map["discount"],
      estimatedTime: map["estimatedTime"],
      rating: (map["rating"] as num).toDouble(), // Ensure it's a double
      reviews: map["reviews"],
      isPopular: map["isPopular"],
      imageUrl: map["imageUrl"],
      details: map["details"],
    );
  }

  // Convert a Service object to a Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "categoryId": categoryId,
      "name": name,
      "price": price,
      "discount": discount,
      "estimatedTime": estimatedTime,
      "rating": rating,
      "reviews": reviews,
      "isPopular": isPopular,
      "imageUrl": imageUrl,
      "details": details,
    };
  }
}
