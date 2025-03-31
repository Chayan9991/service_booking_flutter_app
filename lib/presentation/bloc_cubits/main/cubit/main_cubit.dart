import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_booking_app/core/common/services_list.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  List<Map<String, dynamic>> _cart = []; // Cart list to track selected services

  // Load Categories
  Future<void> loadCategories() async {
    try {
      emit(MainLoading());
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryLoadError(e.toString()));
    }
  }

  // Load Services by Category ID
  Future<void> loadServiceByCategoryId(int categoryId) async {
    try {
      emit(MainLoading());

      List<Map<String, dynamic>> filteredServices =
          services.where((service) => service["categoryId"] == categoryId).toList();

      emit(ServicesLoaded(filteredServices, cart: _cart));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
    }
  }

  // Load All Services
  Future<void> loadAllService() async {
    try {
      emit(MainLoading());
      emit(ServicesLoaded(services, cart: _cart));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
    }
  }

  void addToCart(Map<String, dynamic> service) {
    if (!_cart.any((item) => item["id"] == service["id"])) {
      _cart = List.from(_cart)..add(service); // Ensure a new list is created
      final currentState = state;
      if (currentState is ServicesLoaded) {
        emit(ServicesLoaded(List.from(currentState.services), cart: _cart));
      } else {
        emit(CartUpdated(_cart));
      }
    }
  }

  void removeFromCart(Map<String, dynamic> service) {
    _cart = List.from(_cart)..removeWhere((item) => item["id"] == service["id"]);
    final currentState = state;
    if (currentState is ServicesLoaded) {
      emit(ServicesLoaded(List.from(currentState.services), cart: _cart));
    } else {
      emit(CartUpdated(_cart));
    }
  }

  // Clear Cart After Payment Success
  void clearCart() {
    _cart = [];
    emit(CartUpdated(_cart)); // Notify UI that the cart is empty
  }

  // Fetch User Location
  Future<void> fetchLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError("Please enable location services."));
        return;
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError("Location permission is required to proceed."));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Location permissions are permanently denied."));
        return;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      log("Latitude: \${position.latitude}, Longitude: \${position.longitude}");

      // Convert lat/lon to an address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        throw Exception("Could not retrieve address.");
      }

      Placemark place = placemarks.first;
      String address = "\${place.locality}, \${place.country}";

      emit(LocationLoaded(address));
    } catch (e) {
      emit(LocationError("Failed to retrieve location: \$e"));
    }
  }
}
