part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> props() {
    return [];
  }
}

class CartLoading extends CartState {
  @override
  List<Object?> props() {
    return [];
  }
}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({this.cart = const Cart()});

  @override
  List<Object?> props() {
    return [cart];
  }
}

class CartError extends CartState {
  @override
  List<Object?> props() {
    return [];
  }
}
