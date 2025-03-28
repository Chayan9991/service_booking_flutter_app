import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_booking_app/core/common/services_list.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());


  List<Map<String, dynamic>> _cart = []; // Internal cart state

  // Load Categories
  Future<void> loadCategories() async {
    try {
      emit(MainLoading());
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryLoadError(e.toString()));
    }
  }

  Future<void> loadCategoryByCategoryId(int categoryId) async{
    try {
      emit(MainLoading());

      List<Map<String, dynamic>> filteredCategories =
          categories
              .where((cat) => cat["categoryId"] == categoryId)
              .toList();

      emit(ServicesLoaded(filteredCategories));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
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
      emit(ServicesLoaded(services));
    } catch (e) {
      emit(ServicesLoadError(e.toString()));
    }
  }

  void addToCart(Map<String, dynamic> service) {
  if (!_cart.any((item) => item["id"] == service["id"])) {
    _cart = [..._cart, service];
    final currentState = state;
    if (currentState is ServicesLoaded) {
      emit(ServicesLoaded(currentState.services, cart: _cart));
    } else {
      emit(CartUpdated(_cart));
    }
  }
}

  // Remove from Cart (optional, for future use)
  void removeFromCart(Map<String, dynamic> service) {
    _cart = _cart.where((item) => item != service).toList();
    final currentState = state;
    if (currentState is ServicesLoaded) {
      emit(ServicesLoaded(currentState.services, cart: _cart));
    } else {
      emit(CartUpdated(_cart));
    }
  }
}
