import 'package:equatable/equatable.dart';
import 'package:semesterproject/models/product_model.dart';
import 'package:semesterproject/models/user_model.dart';

class Checkout extends Equatable {
  final User? user;
  final List<Product>? products;
  final String? subTotal;
  final String? deliveryFee;
  final String? total;

  const Checkout({
    this.user = User.empty,
    required this.products,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  List<Object?> props() {
    return [user, products, subTotal, deliveryFee, total];
  }

  Map<String, Object> toDocument() {
    return {
      'user': user?.toDocument() ?? User.empty.toDocument(),
      'products': products!.map((product) => product.name).toList(),
      'subTotal': subTotal!,
      'deliveryFee': deliveryFee!,
      'total': total!,
    };
  }
}
