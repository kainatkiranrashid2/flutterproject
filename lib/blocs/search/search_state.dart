part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> props() => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;

  SearchLoaded({this.products = const <Product>[]});

  @override
  List<Object> props() => [products];
}
