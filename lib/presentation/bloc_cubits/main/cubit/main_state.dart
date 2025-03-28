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
  final List<Map<String, dynamic>> cart; // Added cart

  const ServicesLoaded(this.services, {this.cart = const []});

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
  final List<Map<String, dynamic>> cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}
