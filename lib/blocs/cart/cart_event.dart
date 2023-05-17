part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> props() {
    return [];
  }
}

class LoadCart extends CartEvent {
  @override
  List<Object> props() {
    return [];
  }
}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct(this.product);
  @override
  List<Object> props() {
    return [product];
  }
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);
  @override
  List<Object> props() {
    return [product];
  }
}
