import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:pay/pay.dart';
import 'package:semesterproject/blocs/payment/payment_bloc.dart';
import 'package:semesterproject/models/payment_method_model.dart';
import 'package:semesterproject/widgets/custom_navbar.dart';
import 'package:pay_android/pay_android.dart';
import '../../widgets/custom_appbar.dart';
import 'dart:io';

class PaymentSelection extends StatelessWidget {
  static const String routeName = "/payment-selection";

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PaymentSelection(),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse(
        'https://us-central1-flutter-ecommerce-app-f762a.cloudfunctions.net/StripePayEndPointMethodId');
  }

  const PaymentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Payment Selection'),
        bottomNavigationBar: const CustomNavbar(screen: routeName),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            if (state is PaymentLoaded) {
              print('ibrahim');

              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Text('Add Your Credit Card Details',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Platform.isAndroid
                      ? RawGooglePayButton(
                          type: GooglePayButtonType.pay,
                          onPressed: () {
                            context.read<PaymentBloc>().add(
                                const SelectPaymentMethod(
                                    paymentMethod: PaymentMethod.google_pay));
                            Navigator.pop(context);
                          },
                        )
                      : const SizedBox(),
                  ElevatedButton(
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                            const SelectPaymentMethod(
                                paymentMethod: PaymentMethod.credit_card));
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          color: Colors.blue,
                          child: const Text('Pay with Credit Card'),
                        ),
                      ))
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ));
  }
}
