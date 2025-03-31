import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/data/model/category_model.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';

class ServicesListView extends StatelessWidget {
  final Category selectedCategory;
  const ServicesListView({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final state = context.read<MainCubit>().state as ServicesLoaded;
    final services =
        selectedCategory.categoryId == 0
            ? state.services
            : state.services
                .where(
                  (service) =>
                      service["categoryId"] == selectedCategory.categoryId,
                )
                .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final padding = isLargeScreen ? 100.0 : 8.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      cacheExtent: 500,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        mainAxisExtent: 280,
        crossAxisSpacing: isLargeScreen ? 40.0 : 20.0,
        mainAxisSpacing: 12,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCard(service: service);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceCard({super.key, required this.service});

  static const _ratingIcon = Icon(Icons.star, color: Colors.amber, size: 12);

  double _parsePrice(String? price) =>
      double.tryParse(price?.split('/')[0] ?? '0') ?? 0.0;
  double _calculateDiscountedPrice(String? price, double? discount) {
    final original = _parsePrice(price);
    return original * (1 - (discount ?? 0) / 100);
  }

  void _showServiceDetailsModal(BuildContext context) {
    //context.read<MainCubit>().loadCategoryByCategoryId(service["categoryId"]);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    if (isLargeScreen) {
      showDialog(
        context: context,
        builder:
            (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _buildModalContent(context),
              ),
            ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        builder: (context) => _buildModalContent(context),
      );
    }
  }

  Widget _buildModalContent(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        String categoryName = "Loading...";
        if (state is CategoryLoaded && state.categories.isNotEmpty) {
          categoryName =
              state.categories.first["category"]?.toString() ??
              "Unknown Category";
        } else if (state is ServicesLoaded) {
          // Fallback if category hasn't loaded yet
          categoryName = "Fetching category...";
        }

        final originalPrice = _parsePrice(service["price"]?.toString());
        final discountedPrice = _calculateDiscountedPrice(
          service["price"]?.toString(),
          service["discount"]?.toDouble(),
        );
        final discount = service["discount"]?.toDouble() ?? 0;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service["name"]?.toString() ?? "Unnamed Service",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: 0.2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: service["imageUrl"]?.toString() ?? "",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.blueAccent,
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(
                          Icons.error,
                          size: 40,
                          color: Colors.grey,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow("Category", categoryName),
                _buildDetailRow(
                  "Estimated Time",
                  service["estimatedTime"]?.toString() ?? "N/A",
                ),
                _buildDetailRow(
                  "Price",
                  discount > 0
                      ? "₹${discountedPrice.toStringAsFixed(2)} (₹${originalPrice.toStringAsFixed(2)} - $discount% OFF)"
                      : "₹${originalPrice.toStringAsFixed(2)}",
                ),
                _buildDetailRow(
                  "Rating",
                  "${service["rating"]?.toString() ?? "N/A"} (${service["reviews"]?.toString() ?? "0"} reviews)",
                ),
                const SizedBox(height: 12),
                const Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service["details"]?.toString() ?? "No details available",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.1,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final originalPrice = _parsePrice(service["price"]?.toString());
    final discountedPrice = _calculateDiscountedPrice(
      service["price"]?.toString(),
      service["discount"]?.toDouble(),
    );
    final discount = service["discount"]?.toDouble() ?? 0;

    return SizedBox(
      width: 160,
      height: 280,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showServiceDetailsModal(context),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: service["imageUrl"]?.toString() ?? "",
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        memCacheHeight: 100,
                        memCacheWidth: 160,
                        fadeInDuration: const Duration(milliseconds: 200),
                        placeholder:
                            (context, url) => const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blueAccent,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => const Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            _ratingIcon,
                            const SizedBox(width: 2),
                            Text(
                              "${service["rating"]?.toString() ?? "N/A"} (${service["reviews"]?.toString() ?? "0"})",
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service["name"]?.toString() ?? "Unnamed Service",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "⏳ ${service["estimatedTime"]?.toString() ?? "N/A"}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 6),
            if (discount > 0) ...[
              Row(
                children: [
                  Text(
                    "$discount% OFF",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "₹${originalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "₹${discountedPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                  letterSpacing: 0.2,
                ),
              ),
            ] else ...[
              Text(
                "₹${originalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                  letterSpacing: 0.2,
                ),
              ),
            ],
            const SizedBox(height: 10),
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                final isBooked =
                    state is ServicesLoaded &&
                    state.cart.any((item) => item["name"] == service["name"]);
                return SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed:
                        isBooked
                            ? null
                            : () {
                              context.read<MainCubit>().addToCart(service);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text(
                              //       "${service["name"]} added to cart",
                              //     ),
                              //     duration: const Duration(seconds: 2),
                              //     backgroundColor: Colors.green,
                              //   ),
                              // );
                            },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      backgroundColor:
                          isBooked
                              ? Colors.grey[400]
                              : Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: isBooked ? 0 : 2,
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    child: Text(isBooked ? "Booked" : "Book Now"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
