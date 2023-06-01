import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_bloc.dart';
// import '../../models/models.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CartScreen());
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: const CustomAppBar(title: 'Cart'),
        bottomNavigationBar: const CustomNavbar(screen: routeName),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
              Map cart = state.cart.productQuantity(state.cart.products);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.cart.freeDeliveryString,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Add more Items',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  itemCount: cart.keys.length,
                                  itemBuilder: (context, index) {
                                    return ProductCard.cart(
                                      product: cart.keys.elementAt(index),
                                      quantity: cart.values.elementAt(index),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        const OrderSummary()
                      ]),
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ));
  }
}
