import 'package:flutter/material.dart';

import '../models/product_model.dart';

class OrderSummaryProductCard extends StatelessWidget {
  OrderSummaryProductCard(
      {super.key, required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            height: 80,
            width: 100,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: Theme.of(context).textTheme.titleLarge),
                Text('Qty: 2', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${product.price}',
                    style: Theme.of(context).textTheme.titleLarge),
                Text('Qty: 2', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          )
        ],
      ),
    );
  }
}
