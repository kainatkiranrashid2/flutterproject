part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> props() {
    return [];
  }
}

class LoadProducts extends ProductEvent {}

class UpdateProducts extends ProductEvent {
  final List<Product> products;

  UpdateProducts(this.products);

  @override
  List<Object?> props() {
    return [products];
  }
}
