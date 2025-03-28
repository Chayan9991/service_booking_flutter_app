class CarouselItem {
  final String image;
  final String discount;
  final String title;
  final String subtitle;
  final String buttonText;

  CarouselItem({
    required this.image,
    required this.discount,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      image: json['image'],
      discount: json['discount'],
      title: json['title'],
      subtitle: json['subtitle'],
      buttonText: json['buttonText'],
    );
  }
}
