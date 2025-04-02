import 'package:equatable/equatable.dart';
import 'package:service_booking_app/data/model/services_model.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartUpdated extends CartState {
  final List<ServiceModel> cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}
