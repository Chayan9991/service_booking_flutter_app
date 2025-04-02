import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_booking_app/data/model/services_model.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartUpdated([]));

  List<ServiceModel> _cart = [];

  void addToCart(ServiceModel service) {
    if (!_cart.any((item) => item.id == service.id)) {
      _cart = List.from(_cart)..add(service);
      emit(CartUpdated(_cart));
    }
  }

  int get totalCartItem => _cart.length;

  void removeFromCart(ServiceModel service) {
    _cart = List.from(_cart)..removeWhere((item) => item.id == service.id);
    emit(CartUpdated(_cart));
  }

  void clearCart() {
    _cart = [];
    emit(CartUpdated(_cart));
  }
}
