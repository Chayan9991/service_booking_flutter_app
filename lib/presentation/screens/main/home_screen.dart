import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/data/model/category_model.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';
import 'package:service_booking_app/presentation/widgets/home_carousel.dart';
import 'package:service_booking_app/presentation/widgets/category_listview.dart';
import 'package:service_booking_app/presentation/widgets/services_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final mainCubit = context.read<MainCubit>();

    if (mainCubit.state is! ServicesLoaded) {
      mainCubit.loadCategories();
      mainCubit.loadAllService();
    }
  }

  Category? selectedCategory;

  void updateSelectedCategory(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          if (!isLargeScreen) const _MobileTopBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLargeScreen ? 100 : 8,
                vertical: isLargeScreen ? 0 : 15,
              ),
              child: BlocBuilder<MainCubit, MainState>(
                buildWhen:
                    (previous, current) =>
                        current is MainLoading ||
                        current is ServicesLoaded ||
                        current is ServicesLoadError,
                builder: (context, state) {
                  if (state is ServicesLoadError) {
                    return const Center(child: Text("Failed to load services"));
                  }

                  // Define the list of widgets for lazy loading
                  final children = <Widget>[
                    if (!isLargeScreen) ...[
                      const HomeCarousel(),
                      const SizedBox(height: 20),
                    ],
                    if (isLargeScreen) const SizedBox(height: 30),
                    _buildSectionHeader("Our Services🛠"),
                    const SizedBox(height: 13),
                    CategoryListView(
                      onCategorySelected:
                          updateSelectedCategory, // ✅ Fixed Callback
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade300, thickness: 2),
                    const SizedBox(height: 5),
                    _buildSectionHeader(
                      selectedCategory != null
                          ? "${selectedCategory!.category} 🔥"
                          : "All Services 🔥",
                    ),
                    const SizedBox(height: 10),
                    state is ServicesLoaded
                        ? ServicesListView(
                          selectedCategory:
                              selectedCategory ??
                              Category(
                                categoryId: 0,
                                category: "",
                                icon: "",
                                basePrice: "",
                                details: "",
                              ),
                        )
                        : const Center(child: CircularProgressIndicator()),
                  ];

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: children.length,
                    itemBuilder: (context, index) {
                      return children[index];
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const Spacer(),
        const Text(
          "View All >>>",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class _MobileTopBar extends StatelessWidget {
  const _MobileTopBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        String locationText = "Kolkata, India";
        if (state is LocationLoaded) {
          locationText = state.location;
        } else if (state is LocationError) {
          log(state.message);
          locationText = "Location unavailable";
        }

        return Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        // context.read<MainCubit>().fetchLocation();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Current Location",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                locationText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: null,
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const _SearchBar(),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: "Search Services...",
          hintStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
