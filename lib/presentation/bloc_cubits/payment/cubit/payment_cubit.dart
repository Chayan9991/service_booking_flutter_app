import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  void startPayment() {
    emit(PaymentProcessing());
  }

  void paymentSuccess(String paymentId) {
    emit(PaymentSuccess(paymentId));
  }

  void paymentFailed(String errorMessage) {
    emit(PaymentFailed(errorMessage));
  }
}
