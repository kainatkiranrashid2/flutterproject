import 'package:flutter/material.dart';
import 'package:semesterproject/models/category_model.dart';
import 'package:semesterproject/models/product_model.dart';

import '../screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('this is route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      // ignore: no_duplicate_case_values
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
          appBar: AppBar(
        title: const Text('Error'),
      )),
    );
  }
}
