import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/models/product_model.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard.catalog(
      {super.key,
      required this.product,
      this.widthFactor = 2.1,
      this.quantity,
      this.height = 150,
      this.isCatalog = true,
      this.isCart = false,
      this.isSummary = false,
      this.isWishlist = false,
      this.iconColor = Colors.white,
      this.fontColor = Colors.white});

  const ProductCard.cart(
      {super.key,
      required this.product,
      this.widthFactor = 1.1,
      this.quantity,
      this.height = 80,
      this.isCatalog = false,
      this.isCart = true,
      this.isSummary = false,
      this.isWishlist = false,
      this.iconColor = Colors.blue,
      this.fontColor = Colors.blue});

  const ProductCard.wishlist(
      {super.key,
      required this.product,
      this.widthFactor = 1.2,
      this.quantity,
      this.height = 150,
      this.isCatalog = false,
      this.isCart = false,
      this.isSummary = false,
      this.isWishlist = true,
      this.iconColor = Colors.white,
      this.fontColor = Colors.white});

  const ProductCard.summary(
      {super.key,
      required this.product,
      this.widthFactor = 2.5,
      this.quantity,
      this.height = 80,
      this.isCatalog = false,
      this.isCart = false,
      this.isSummary = true,
      this.isWishlist = false,
      this.iconColor = Colors.blue,
      this.fontColor = Colors.blue});

  final Product product;
  final int? quantity;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final double widthFactor;
  final Color iconColor;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / widthFactor;
    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: product,
          );
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  ProductImage(
                    adjWidth: 120,
                    height: height,
                    product: product,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProductInformation(
                      product: product,
                      fontColor: fontColor,
                      quantity: quantity,
                      isOrderSummary: isSummary ? true : false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ProductActions(
                    product: product,
                    isCatalog: isCatalog,
                    isWishlist: isWishlist,
                    isCart: isCart,
                    iconColor: iconColor,
                    quantity: quantity,
                  )
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ProductImage(
                  adjWidth: adjWidth,
                  height: height,
                  product: product,
                ),
                ProductBackground(
                  adjWidth: adjWidth,
                  widgets: [
                    ProductInformation(
                      product: product,
                      fontColor: fontColor,
                    ),
                    ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    super.key,
    required this.product,
    required this.isCatalog,
    required this.isWishlist,
    required this.isCart,
    required this.iconColor,
    this.quantity,
  });

  final Product product;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is CartLoaded) {
          IconButton addProduct = IconButton(
            icon: Icon(
              Icons.add_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to your Cart!'),
                ),
              );
              context.read<CartBloc>().add(AddProduct(product));
            },
          );

          IconButton removeProduct = IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Cart!'),
                ),
              );
              context.read<CartBloc>().add(RemoveProduct(product));
            },
          );

          IconButton removeFromWishlist = IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Wishlist!'),
                ),
              );
              context
                  .read<WishlistBloc>()
                  .add(RemoveProductFromWishList(product));
            },
          );

          Text productQuantity = Text(
            '$quantity',
            style: Theme.of(context).textTheme.headlineMedium,
          );

          if (isCatalog) {
            return Row(children: [addProduct]);
          } else if (isWishlist) {
            return Row(children: [addProduct, removeFromWishlist]);
          } else if (isCart) {
            return Row(children: [removeProduct, productQuantity, addProduct]);
          } else {
            return const SizedBox();
          }
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground({
    super.key,
    required this.adjWidth,
    required this.widgets,
  });

  final double adjWidth;
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: adjWidth - 5,
        height: 80,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha(100),
        ),
        child: Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(30),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [...widgets],
                ))));
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    super.key,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
    required this.product,
  });

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: fontColor),
            ),
            Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary
            ? Text('Qty. $quantity',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: fontColor))
            : const SizedBox()
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.adjWidth,
    required this.height,
    required this.product,
  });

  final double adjWidth;
  final Product product;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adjWidth,
      height: height,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
