import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:semesterproject/models/product_model.dart';
import '../../blocs/wishlist/wishlist_bloc.dart';
import '../../widgets/widgets.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const WishlistScreen());
  }

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: const CustomAppBar(title: 'Wishlist'),
        bottomNavigationBar: const CustomNavbar(),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WishlistLoaded) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 2.1),
                itemCount: state.wishlist.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: ProductCard(
                      product: state.wishlist.products[index],
                      widthFactor: 1.2,
                      leftPosition: 100,
                      isWishlist: true,
                    ),
                  );
                },
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ));
  }
}
