part of 'bills_cubit.dart';

@immutable
sealed class BillsState {}

final class BillsInitial extends BillsState {}

final class BillsLoading extends BillsState {}

final class BillsSuccess extends BillsState {
  final List<BillsEntity> bills;
  BillsSuccess(this.bills);
}

final class BillsError extends BillsState {
  final String message;
  BillsError(this.message);
}
