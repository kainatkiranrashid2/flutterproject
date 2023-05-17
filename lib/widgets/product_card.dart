import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/models/product_model.dart';

import '../blocs/cart/cart_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;
  const ProductCard(
      {super.key,
      required this.product,
      this.widthFactor = 2.5,
      this.leftPosition = 5,
      this.isWishlist = false});

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Stack(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: widthValue,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: widthValue - 5 - leftPosition,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: widthValue - 15 - leftPosition,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '\$${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CartLoaded) {
                        return Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.white,
                            onPressed: () {
                              context.read<CartBloc>().add(AddProduct(product));
                            },
                          ),
                        );
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  ),
                  isWishlist
                      ? Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        )
                      : const SizedBox(),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
