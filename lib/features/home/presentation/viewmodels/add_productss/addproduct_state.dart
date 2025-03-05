part of 'addproduct_cubit.dart';

@immutable
sealed class AddproductState {}

final class AddproductInitial extends AddproductState {}

final class AddproductLoading extends AddproductState {}

final class AddproductSuccess extends AddproductState {
  final AddProductEntity addProductEntity;

  AddproductSuccess(this.addProductEntity);
}

final class Addproductfailure extends AddproductState {
  final String message;

  Addproductfailure(this.message);
}
