import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';

class CustomTopBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;

  const CustomTopBar({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo & App Name
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "ServEase",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Book a Service in Ease",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),

          // Navigation Items
          _buildNavItem(Icons.home, "Home", 0),
          const SizedBox(width: 15),
          _buildNavItem(Icons.category, "Browse", 1),
          const SizedBox(width: 15),
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              final cartCount = state is ServicesLoaded ? state.cart.length : 0;
              return _buildNavItemWithBadge(
                Icons.shopping_cart,
                "Cart",
                2,
                cartCount,
              );
            },
          ),
          const SizedBox(width: 15),
          _buildNavItem(Icons.person, "Profile", 3),

          // Search Bar (Only visible on web)
          if (isLargeScreen) ...[
            const SizedBox(width: 20),
            _buildSearchBar(context),
          ],
        ],
      ),
    );
  }

  // Navigation Item Widget (without badge)
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => onNavTap(index),
      child: Row(
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? Colors.white : Colors.white70,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: selectedIndex == index ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Navigation Item Widget with Badge (for Cart)
  Widget _buildNavItemWithBadge(
    IconData icon,
    String label,
    int index,
    int cartCount,
  ) {
    return GestureDetector(
      onTap: () => onNavTap(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: selectedIndex == index ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: selectedIndex == index ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
          if (cartCount > 0)
            Positioned(
              right: 35,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
                child: Text(
                  cartCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Search Bar (Only Visible on Web)
  Widget _buildSearchBar(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.surface,
          ),
          hintText: "Search Services...",
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white70),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
