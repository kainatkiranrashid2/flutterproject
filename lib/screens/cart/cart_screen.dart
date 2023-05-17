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
        bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Text('GO TO CHECKOUT',
                        style: Theme.of(context).textTheme.displaySmall
                        // .copyWith(color: Colors.white),
                        ),
                  )
                ],
              ),
            )),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
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
                                    backgroundColor: Colors.black,
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
                                  itemCount: state.cart
                                      .productQuantity(state.cart.products)
                                      .keys
                                      .length,
                                  itemBuilder: (context, index) {
                                    return CartProductCard(
                                      product: state.cart
                                          .productQuantity(state.cart.products)
                                          .keys
                                          .elementAt(index),
                                      quantity: state.cart
                                          .productQuantity(state.cart.products)
                                          .values
                                          .elementAt(index),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SUBTOTAL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        '\$${state.cart.subTotalString}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'DELIVERY',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        '\$${state.cart.deliveryFeeString}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(50),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TOTAL',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                        Text(
                                          '\$${state.cart.totalString}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
