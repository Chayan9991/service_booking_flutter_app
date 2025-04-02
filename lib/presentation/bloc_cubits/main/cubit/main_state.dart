import 'package:equatable/equatable.dart';

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

// Services States
final class ServicesLoaded extends MainState {
  final List<Map<String, dynamic>> services;
  const ServicesLoaded(this.services);

  @override
  List<Object> get props => [services];
}

final class ServicesLoadError extends MainState {
  final String message;
  const ServicesLoadError(this.message);

  @override
  List<Object> get props => [message];
}

// Location States
final class LocationLoaded extends MainState {
  final String location;
  const LocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

final class LocationError extends MainState {
  final String message;
  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
