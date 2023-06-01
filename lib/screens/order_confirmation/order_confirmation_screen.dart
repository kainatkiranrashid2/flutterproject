import 'package:flutter/material.dart';
import 'package:semesterproject/widgets/custom_appbar.dart';
import 'package:semesterproject/widgets/custom_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semesterproject/widgets/order_summary.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const String routeName = '/order-confirmation';
  OrderConfirmationScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => OrderConfirmationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: const CustomNavbar(screen: routeName),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.blue,
                width: double.infinity,
                height: 300,
              ),
              Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: 125,
                  child: SvgPicture.asset('assets/svgs/garlands.svg')),
              Positioned(
                top: 250,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Your order is complete!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Order Code: #k321-ekd3',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 20),
                Text('Thankyou for purchasing from our shop',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                Text('Order Code: #k321-ekd3',
                    style: Theme.of(context).textTheme.headlineSmall),
                const OrderSummary(),
                const SizedBox(height: 20),
                Text(
                  'ORDER DETAILS',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Divider(thickness: 2),
                // const SizedBox(height: 5),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProductCard.summary(
                      product: Product.products[0],
                      quantity: 2,
                    ),
                    ProductCard.summary(
                      product: Product.products[0],
                      quantity: 2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
