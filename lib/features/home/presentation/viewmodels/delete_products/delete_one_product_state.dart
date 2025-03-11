part of 'delete_one_product_cubit.dart';

@immutable
sealed class DeleteOneProductState {}

final class DeleteOneProductInitial extends DeleteOneProductState {}

final class DeleteOneProductLoading extends DeleteOneProductState {}

final class DeleteOneProductSuccess extends DeleteOneProductState {
  final String message;

  DeleteOneProductSuccess(this.message);
}

final class DeleteOneProductFailure extends DeleteOneProductState {
  final String message;

  DeleteOneProductFailure(this.message);
}
