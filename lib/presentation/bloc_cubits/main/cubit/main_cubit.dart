import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_booking_app/core/common/services_list.dart';
import 'package:service_booking_app/data/model/services_model.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  List<Map<String, dynamic>> _allServices = []; // Stores all services names
  List<Map<String, dynamic>> _filteredServices = [];

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
          services
              .where((service) => service["categoryId"] == categoryId)
              .toList();
      emit(ServicesLoaded(filteredServices));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
    }
  }

  // Load All Services
  Future<void> loadAllService() async {
    try {
      emit(MainLoading());
      _allServices = services;
      _filteredServices = _allServices;
      emit(ServicesLoaded(_filteredServices));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
    }
  }

  // Real time Search Query functionality (Search Items)
  void updateSearchQuery(String query) {
    if (query.isEmpty) {
      _filteredServices = _allServices;
    } else {
      _filteredServices =
          _allServices
              .where(
                (service) => service["name"].toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
    }
    emit(ServicesLoaded(_filteredServices));
  }

  // Fetch User Location
  Future<void> fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError("Please enable location services."));
        return;
      }

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

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      log("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        throw Exception("Could not retrieve address.");
      }

      Placemark place = placemarks.first;
      String address = "${place.locality}, ${place.country}";

      emit(LocationLoaded(address));
    } catch (e) {
      emit(LocationError("Failed to retrieve location: $e"));
    }
  }
}
