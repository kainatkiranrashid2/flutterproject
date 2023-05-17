part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> props() {
    return [];
  }
}

class LoadWishList extends WishlistEvent {}

class AddProductToWishlist extends WishlistEvent {
  final Product product;
  const AddProductToWishlist(this.product);

  @override
  List<Object?> props() {
    return [product];
  }
}

class RemoveProductFromWishList extends WishlistEvent {
  final Product product;
  const RemoveProductFromWishList(this.product);

  @override
  List<Object?> props() {
    return [product];
  }
}
