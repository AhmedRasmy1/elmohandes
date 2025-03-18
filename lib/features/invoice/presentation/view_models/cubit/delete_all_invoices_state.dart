part of 'delete_all_invoices_cubit.dart';

@immutable
sealed class DeleteAllInvoicesState {}

final class DeleteAllInvoicesInitial extends DeleteAllInvoicesState {}

final class DeleteAllInvoicesLoading extends DeleteAllInvoicesState {}

final class DeleteAllInvoicesSuccess extends DeleteAllInvoicesState {
  final String message;

  DeleteAllInvoicesSuccess(this.message);
}

final class DeleteAllInvoicesFailure extends DeleteAllInvoicesState {
  final String message;

  DeleteAllInvoicesFailure(this.message);
}
