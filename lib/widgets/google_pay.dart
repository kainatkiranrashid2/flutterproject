import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../models/models.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
            label: product.name,
            amount: product.price.toString(),
            type: PaymentItemType.item,
            status: PaymentItemStatus.final_price,
          ),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: FutureBuilder<PaymentConfiguration>(
        future:
            PaymentConfiguration.fromAsset('payment_profile_google_pay.json'),
        builder: (BuildContext context,
            AsyncSnapshot<PaymentConfiguration> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.blue, 
              child: GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 10),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const CircularProgressIndicator(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
