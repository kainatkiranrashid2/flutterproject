part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> props() {
    return [];
  }
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded({this.products = const <Product>[]});
  @override
  List<Object?> props() {
    return [products];
  }
}

// class ProductLoaded extends CategoryState {}
