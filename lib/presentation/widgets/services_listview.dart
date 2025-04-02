import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/data/model/category_model.dart';
import 'package:service_booking_app/data/model/services_model.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_state.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_state.dart';

class ServicesListView extends StatelessWidget {
  final CategoryModel selectedCategory;
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
        maxCrossAxisExtent: 180,
        mainAxisExtent: 250,
        crossAxisSpacing: isLargeScreen ? 40.0 : 20.0,
        mainAxisSpacing: 12,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = ServiceModel.fromMap(services[index]);
        return ServiceCard(serviceModel: service);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final ServiceModel serviceModel;

  const ServiceCard({super.key, required this.serviceModel});

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

        final originalPrice = _parsePrice(serviceModel.price.toString());
        final discountedPrice = _calculateDiscountedPrice(
          serviceModel.price.toString(),
          serviceModel.discount.toDouble(),
        );
        final discount = serviceModel.discount.toDouble();

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
                      serviceModel.name.toString(),
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
                  child: Image.asset(
                    //fadein.networkImage for network image load
                    serviceModel.imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow("Category", categoryName),
                _buildDetailRow(
                  "Estimated Time",
                  serviceModel.estimatedTime.toString(),
                ),
                _buildDetailRow(
                  "Price",
                  discount > 0
                      ? "₹${discountedPrice.toStringAsFixed(2)} (₹${originalPrice.toStringAsFixed(2)} - $discount% OFF)"
                      : "₹${originalPrice.toStringAsFixed(2)}",
                ),
                _buildDetailRow(
                  "Rating",
                  "${serviceModel.rating.toString()} (${serviceModel.reviews.toString()} reviews)",
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
                  serviceModel.details.toString(),
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
    final originalPrice = _parsePrice(serviceModel.price.toString());
    final discountedPrice = _calculateDiscountedPrice(
      serviceModel.price.toString(),
      serviceModel.discount.toDouble(),
    );
    final discount = serviceModel.discount.toDouble();

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
                      child: Image.asset(
                        //fadein.networkImage for network image load
                        serviceModel.imageUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            _ratingIcon,
                            const SizedBox(width: 2),
                            Text(
                              "${serviceModel.rating.toString()} (${serviceModel.reviews.toString()})",
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
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "$discount% OFF",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              serviceModel.name.toString(),
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
              "⏳ ${serviceModel.estimatedTime.toString()}",
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
                    "₹${discountedPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueAccent,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(width: 6),
                  Text(
                    "₹${originalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
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
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cart = state is CartUpdated ? state.cart : [];
                final isBooked = cart.any(
                  (item) => item.name == serviceModel.name,
                );

                return SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed:
                        isBooked
                            ? null
                            : () {
                              context.read<CartCubit>().addToCart(serviceModel);
                            },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (isBooked) return Colors.grey.shade300;
                        if (states.contains(WidgetState.hovered) ||
                            states.contains(WidgetState.pressed)) {
                          return Theme.of(context).primaryColor;
                        }
                        return Colors.white;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (isBooked) return Colors.grey.shade700;
                        if (states.contains(WidgetState.hovered) ||
                            states.contains(WidgetState.pressed)) {
                          return Colors.white;
                        }
                        return Theme.of(context).primaryColor;
                      }),
                      side: WidgetStateProperty.resolveWith<BorderSide>((
                        states,
                      ) {
                        if (isBooked) {
                          return BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          );
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          );
                        }
                        return BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        );
                      }),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      isBooked ? "Added" : "Add to Cart",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
