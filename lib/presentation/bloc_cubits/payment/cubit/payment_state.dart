part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentId;
  PaymentSuccess(this.paymentId);

  @override
  List<Object> get props => [paymentId];
}

class PaymentFailed extends PaymentState {
  final String errorMessage;
  PaymentFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
