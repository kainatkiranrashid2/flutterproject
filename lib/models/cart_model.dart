import 'package:equatable/equatable.dart';
import 'package:semesterproject/models/models.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  double get subTotal =>
      products.fold(0, (total, current) => total + current.price);
  String get subTotalString => subTotal.toStringAsFixed(2);

  Map productQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double deliveryFee(subTotal) {
    if (subTotal >= 20.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double total(subTotal, deliveryFee) {
    return subTotal + deliveryFee(subTotal);
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 20.0) {
      return 'You have free delivery';
    } else {
      double missing = 20.0 - subTotal;

      return 'Add \$${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);
  String get freeDeliveryString => freeDelivery(subTotal);
  String get totalString => total(subTotal, deliveryFee).toStringAsFixed(2);

  @override
  List<Object?> props() {
    return [products];
  }
}
