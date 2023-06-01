import 'package:flutter/material.dart';
import 'package:semesterproject/blocs/category/category_bloc.dart';

import '../../blocs/product/product_bloc.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ecommerce app'),
      bottomNavigationBar: const CustomNavbar(
        screen: routeName,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroCarousel(),
            SearchBox(), // ignore: prefer_const_constructors
            const SectionTitle(title: 'RECOMMENDED'),
            _ProductCarousel(isPopular: false),
            const SectionTitle(title: 'MOST POPULAR'),
            _ProductCarousel(isPopular: true),
          ],
        ),
      ),
    );
  }
}

class _ProductCarousel extends StatelessWidget {
  const _ProductCarousel({super.key, required this.isPopular});
  final bool isPopular;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      print(state);
      if (state is ProductLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ProductLoaded) {
        var products = (isPopular)
            ? state.products.where((product) => product.isPopular).toList()
            : state.products.where((product) => product.isRecommended).toList();
        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
              height: 165,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ProductCard.catalog(product: products[index]),
                  );
                },
              )),
        );
      } else {
        return const Text('Something went wrong');
      }
    });
  }
}

class _HeroCarousel extends StatelessWidget {
  const _HeroCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CategoryLoaded) {
        return CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: state.categories
              .map((category) => HeroCarouselCard(category: category))
              .toList(),
        );
      } else {
        return const Text('Something went wrong');
      }
    });
  }
}
