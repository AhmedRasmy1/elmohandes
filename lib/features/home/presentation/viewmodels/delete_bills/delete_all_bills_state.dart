part of 'delete_all_bills_cubit.dart';

@immutable
sealed class DeleteAllBillsState {}

final class DeleteAllBillsInitial extends DeleteAllBillsState {}

final class DeleteAllBillsLoading extends DeleteAllBillsState {}

final class DeleteAllBillsSuccess extends DeleteAllBillsState {}

final class DeleteAllBillsFailure extends DeleteAllBillsState {}
