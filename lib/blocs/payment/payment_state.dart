part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> props() => [];
}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentMethod? paymentMethod;

  const PaymentLoaded({
    this.paymentMethod,
  });

  @override
  List<Object?> props() {
    return [paymentMethod];
  }
}
