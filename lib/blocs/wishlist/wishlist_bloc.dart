import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:semesterproject/models/product_model.dart';
import 'package:semesterproject/models/wishlist_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishList>(_onLoadWishList);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishList>(_onRemoveProductFromWishList);
  }
  void _onLoadWishList(event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddProductToWishlist(event, Emitter<WishlistState> emit) {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..add(event.product))));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishList(event, Emitter<WishlistState> emit) {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..remove(event.product))));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }
}
