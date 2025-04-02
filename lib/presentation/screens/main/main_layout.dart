import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_cubit.dart';
import 'package:service_booking_app/presentation/bloc_cubits/cart/cubit/cart_state.dart';
import 'package:service_booking_app/presentation/screens/main/cart_screen.dart';
import 'package:service_booking_app/presentation/screens/main/home_screen.dart';
import 'package:service_booking_app/presentation/screens/main/profile_screen.dart';
import 'package:service_booking_app/presentation/widgets/custom_topbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    //  const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Column(
        children: [
          if (isLargeScreen)
            CustomTopBar(
              selectedIndex: _selectedIndex,
              onNavTap: _onItemTapped,
            ),
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _screens),
          ),
        ],
      ),
      bottomNavigationBar:
          isLargeScreen
              ? null
              : BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cartCount =
                      state is CartUpdated ? state.cart.length : 0;
                  return BottomNavigationBar(
                    iconSize: 20,
                    selectedLabelStyle: const TextStyle(fontSize: 12),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor:
                        Theme.of(context).colorScheme.secondary,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      // const BottomNavigationBarItem(
                      //   icon: Icon(Icons.build),
                      //   label: "Browse",
                      // ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          children: [
                            const Icon(Icons.shopping_cart),
                            if (cartCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 10,
                                    minHeight: 10,
                                  ),
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
                        label: "Cart",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person, size: 22),
                        label: "Profile",
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
