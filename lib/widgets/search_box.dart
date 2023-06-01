import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/blocs/search/search_bloc.dart';
import 'package:semesterproject/widgets/widgets.dart';

import '../models/models.dart';

class SearchBox extends StatelessWidget {
  final Category? category;
  const SearchBox({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }
        if (state is SearchLoaded) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Search for a product',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                      onChanged: (value) {
                        context.read<SearchBloc>().add(SearchProduct(
                            productName: value, category: category));
                      },
                    ))
                  ],
                ),
                state.products.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ProductCard.catalog(
                              product: state.products[index],
                              widthFactor: 1.1,
                            ),
                          );
                        },
                      )
                    : SizedBox()
              ],
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
