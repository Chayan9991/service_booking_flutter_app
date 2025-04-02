import 'dart:developer';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/core/common/services_list.dart';
import 'package:service_booking_app/core/dependency_injection/service_locator.dart';
import 'package:service_booking_app/data/model/category_model.dart';
import 'package:service_booking_app/data/model/services_model.dart';
import 'package:service_booking_app/logic/services/razorpay_service.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_state.dart';
import 'package:service_booking_app/presentation/screens/main/order_receipt_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final RazorpayService _razorpayService = getIt<RazorpayService>();

  @override
  void initState() {
    super.initState();
    js.context['onPaymentSuccessDart'] = (String paymentId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderReceiptScreen(paymentId: paymentId),
        ),
      );
    };
  }

  double _parsePrice(String price, double discount) {
    final value = double.tryParse(price.split('/')[0]) ?? 0.0;
    return value * (1 - discount / 100);
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final totalCartCount = state is CartUpdated ? state.cart.length : 0;
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Your Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: isLargeScreen ? Colors.black87 : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: " ( $totalCartCount items )",
                    style: TextStyle(
                      color: isLargeScreen ? Colors.black87 : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor:
            !isLargeScreen
                ? Theme.of(context).primaryColor
                : Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 100 : 8,
          vertical: isLargeScreen ? 0 : 15,
        ),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cart = state is CartUpdated ? state.cart : <ServiceModel>[];
            final subtotal = cart.fold<double>(
              0,
              (sum, item) => sum + _parsePrice(item.price, item.discount),
            );

            if (cart.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 60,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Your Cart is Empty",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                bool isLargeScreen =
                    constraints.maxWidth > 600; // Adjust layout for screen size

                return Column(
                  children: [
                    Divider(thickness: 1, color: Colors.grey.shade400),
                    // Left Column - Cart Items List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final item = cart[index];
                          final originalPrice = double.parse(
                            item.price.split('/')[0],
                          );

                          final category = categories.firstWhere(
                            (cat) => cat["categoryId"] == item.categoryId,
                          );

                          final CategoryModel categoryModel =
                              CategoryModel.fromMap(category);

                          final priceAfterDiscount = _parsePrice(
                            item.price,
                            item.discount,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item.imageUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categoryModel.category,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "₹${originalPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                              decorationColor: Colors.black,
                                              decorationThickness: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "₹${priceAfterDiscount.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context.read<CartCubit>().removeFromCart(
                                      item,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Right Column - Subtotal, Tax, Grand Total, and Checkout
                    if (!isLargeScreen)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildSummarySection(cart, subtotal),
                      ),
                    if (isLargeScreen)
                      // For large screens, it will remain on the right side
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: _buildSummarySection(cart, subtotal),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Separate widget for bottom summary section
  Widget _buildSummarySection(List cart, double subtotal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Subtotal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "₹${subtotal.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tax (5%)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "₹${(subtotal * 0.05).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Grand Total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${(subtotal * 1.05).toStringAsFixed(2)}", // 5% tax added
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed:
                cart.isEmpty
                    ? null
                    : () => _razorpayService.openCheckout(subtotal),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Proceed to Payment"),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Text(
                "Terms & Conditions | Refund Policy | Privacy Policy",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 5),
              Text(
                "📍 Nagar Mathabhanga, Coochbehar, WB 736146",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "📞 7384064561 | ✉️ barmanchayan10@gmail.com",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
