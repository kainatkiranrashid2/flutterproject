import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';
  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category),
    );
  }

  final Category category;

  const CatalogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: CustomAppBar(title: category.name),
        bottomNavigationBar: const CustomNavbar(),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.05),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
              product: categoryProducts[index],
              widthFactor: 2.2,
            );
          },
        ));
  }
}
