part of 'update_products_cubit.dart';

@immutable
sealed class UpdateProductsState {}

final class UpdateProductsInitial extends UpdateProductsState {}

final class UpdateProductsLoading extends UpdateProductsState {}

final class UpdateProductsSuccess extends UpdateProductsState {
  final UpdateProductEntity updateProductEntity;

  UpdateProductsSuccess(this.updateProductEntity);
}

final class UpdateProductsFailure extends UpdateProductsState {
  final String message;

  UpdateProductsFailure(this.message);
}
