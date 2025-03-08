part of 'delete_one_bill_cubit.dart';

@immutable
sealed class DeleteOneBillState {}

final class DeleteOneBillInitial extends DeleteOneBillState {}

final class DeleteOneBillLoading extends DeleteOneBillState {}

final class DeleteOneBillSuccess extends DeleteOneBillState {
  final String message;
  DeleteOneBillSuccess(this.message);
}

final class DeleteOneBillFailure extends DeleteOneBillState {
  final String message;
  DeleteOneBillFailure(this.message);
}
