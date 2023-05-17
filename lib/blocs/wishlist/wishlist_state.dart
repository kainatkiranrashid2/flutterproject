part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> props() {
    return [];
  }
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final Wishlist wishlist;

  const  WishlistLoaded({this.wishlist = const Wishlist()});

  @override
  List<Object?> props() {
    return [wishlist];
  }
}

class WishlistError extends WishlistState {}
