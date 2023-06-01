import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:semesterproject/models/product_model.dart';
import 'package:semesterproject/models/wishlist_model.dart';
import 'package:semesterproject/repositories/local_storage/local_storage_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;
  WishlistBloc({
    required LocalStorageRepository localStorageRepository,
  })  : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<LoadWishList>(_onLoadWishList);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishList>(_onRemoveProductFromWishList);
  }
  void _onLoadWishList(event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded(wishlist: Wishlist(products: products)));
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddProductToWishlist(event, Emitter<WishlistState> emit) async {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);

        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products:
                  List.from((this.state as WishlistLoaded).wishlist.products)
                    ..add(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishList(event, Emitter<WishlistState> emit) async {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();

        _localStorageRepository.removeProductFromWishlist(box, event.product);
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products:
                    List.from((this.state as WishlistLoaded).wishlist.products)
                      ..remove(event.product))));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }
}
