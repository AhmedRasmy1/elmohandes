part of 'add_bill_cubit.dart';

@immutable
sealed class AddBillState {}

final class AddBillInitial extends AddBillState {}

final class AddBillLoading extends AddBillState {}

final class AddBillSuccess extends AddBillState {
  final AddBillEntity addBillEntity;

  AddBillSuccess(this.addBillEntity);
}

final class AddBillFailure extends AddBillState {
  final String message;

  AddBillFailure(this.message);
}
