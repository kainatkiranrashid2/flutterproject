import 'package:equatable/equatable.dart';
import 'package:semesterproject/models/product_model.dart';

class Wishlist extends Equatable {
  final List<Product> products;
  const Wishlist({this.products = const <Product>[]});
  @override
  List<Object?> props() {
    return [products];
  }
}
