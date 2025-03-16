part of 'cart_details_cubit.dart';

@immutable
sealed class CartDetailsState {}

final class CartDetailsInitial extends CartDetailsState {}

final class CartDetailsLoading extends CartDetailsState {}

final class CartDetailsSuccess extends CartDetailsState {
  final List<CartDetailsEntity> cartDetails;

  CartDetailsSuccess(this.cartDetails);
}

final class CartDetailsFailure extends CartDetailsState {
  final String message;

  CartDetailsFailure(this.message);
}
