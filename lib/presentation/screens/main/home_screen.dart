import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/presentation/bloc_cubits/main/cubit/main_cubit.dart';
import 'package:service_booking_app/presentation/screens/main/home_carousel.dart';
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
    context.read<MainCubit>().loadCategories();
    context.read<MainCubit>().loadAllService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 20),
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
                    _buildSectionHeader("Our Services🛠"),
                    const SizedBox(height: 10),
                    const CategoryListView(),
                    const SizedBox(height: 20),
                    _buildSectionHeader("All Services🔥"),
                    const SizedBox(height: 10),
                    state is ServicesLoaded
                        ? const ServicesListView()
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

// Extracted MobileTopBar as a const widget
class _MobileTopBar extends StatelessWidget {
  const _MobileTopBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Location",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        "New York City",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: null, // Disabled for now; add logic if needed
                icon: Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ),
        const _SearchBar(),
      ],
    );
  }
}

// Extracted SearchBar as a const widget
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
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12),
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
