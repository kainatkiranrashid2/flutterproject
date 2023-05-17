import 'package:flutter/material.dart';
import 'package:semesterproject/models/models.dart';
import 'package:semesterproject/widgets/widgets.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  const ProductCarousel({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
          height: 165,
          child: ListView.builder(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ProductCard(product: products[index]),
              );
            },
          )),
    );
  }
}
