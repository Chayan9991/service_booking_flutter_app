part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class MainLoading extends MainState {}

// Category States
final class CategoryLoaded extends MainState {
  final List<Map<String, dynamic>> categories;
  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoryLoadError extends MainState {
  final String message;
  const CategoryLoadError(this.message);

  @override
  List<Object> get props => [message];
}

class ServicesLoaded extends MainState {
  final List<Map<String, dynamic>> services;
  final List<ServiceModel> cart;

  const ServicesLoaded(this.services, {required this.cart});

  @override
  List<Object> get props => [services, cart];
}


final class ServicesLoadError extends MainState {
  final String message;
  const ServicesLoadError(this.message);

  @override
  List<Object> get props => [message];
}

//cart
class CartUpdated extends MainState {
  final List<dynamic> cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}

//Location Stated

class LocationLoaded extends MainState {
  final String location;
  const LocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

class LocationError extends MainState {
  final String message;
  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
