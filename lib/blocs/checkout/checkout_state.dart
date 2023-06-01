part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> props() {
    return [];
  }
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final User? user;
  final List<Product>? products;
  final String? subTotal;
  final String? deliveryFee;
  final String? total;
  final Checkout checkout;
  final PaymentMethod? paymentMethod;

  CheckoutLoaded(
      {this.user,
      this.products,
      this.subTotal,
      this.deliveryFee,
      this.total,
      this.paymentMethod})
      : checkout = Checkout(
            user: user,
            products: products,
            subTotal: subTotal,
            deliveryFee: deliveryFee,
            total: total);

  @override
  List<Object?> props() {
    return [
      user,
      products,
      subTotal,
      deliveryFee,
      total,
      checkout,
      paymentMethod
    ];
  }
}
